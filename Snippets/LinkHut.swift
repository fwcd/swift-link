// Swift port of link/extensions/abl_link/examples/link_hut/main.c
// Copyright 2021, Ableton AG, Berlin. All rights reserved.
// License: GPL v2 or later

import Foundation
import Link

struct State {
    let link = Link()
    var running: Bool = true
    var quantum: Double = 4
}

func disableBufferedInput() {
    var t = termios()
    tcgetattr(STDIN_FILENO, &t)
    t.c_lflag &= ~tcflag_t(ICANON)
    tcsetattr(STDIN_FILENO, TCSANOW, &t)
}

func enableBufferedInput() {
    var t = termios()
    tcgetattr(STDIN_FILENO, &t)
    t.c_lflag |= tcflag_t(ICANON)
    tcsetattr(STDIN_FILENO, TCSANOW, &t)
}

/// Drop-in replacement for `FD_ZERO(set); FD_SET(0, set)`
func fdSetFirst(_ set: inout fd_set) {
#if os(Linux)
    set.__fds_bits = (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
#else
    set.fds_bits = (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
#endif
}

func waitForInput() -> Bool {
    var selectset = fd_set()
    var timeout = timeval(tv_sec: 0, tv_usec: 50000)
    fdSetFirst(&selectset)
    let ret = select(1, &selectset, nil, nil, &timeout)
    if ret > 0 {
        return true
    }
    return false
}

func clearLine() {
    print("   \r", terminator: "")
    fflush(stdout)
}

func printHelp() {
    print("\n\n < L I N K  H U T >\n")
    print("usage:")
    print("  enable / disable Link: a")
    print("  start / stop: space")
    print("  decrease / increase tempo: w / e")
    print("  decrease / increase quantum: r / t")
    print("  enable / disable start stop sync: s")
    print("  quit: q")
}

func printStateHeader() {
    print("\nenabled | num peers | quantum | start stop sync | tempo   | beats   | metro")
}

func pad<T>(_ subject: T, _ length: Int) -> String {
    String(describing: subject).padding(toLength: length, withPad: " ", startingAt: 0)
}

@MainActor
func print(state: State) {
    let sessionState = state.link.appSessionState
    let enabled = state.link.isEnabled ? "yes" : "no"
    let peerCount = state.link.peerCount
    let startStop = state.link.isStartStopSyncEnabled ? "yes" : "no"
    let playing = sessionState.isPlaying ? "[playing]" : "[stopped]"
    let tempo = sessionState.tempo
    let beats = sessionState.beat(quantum: state.quantum)
    let phase = sessionState.phase(quantum: state.quantum)
    var line = "\(pad(enabled, 7)) | \(pad(peerCount, 9)) | \(pad(state.quantum, 7)) | \(pad(startStop, 3)) \(pad(playing, 11)) | \(String(format: "%7.2f | %7.2f", tempo, beats)) | "
    for i in 0..<Int(state.quantum.rounded(.up)) {
        if Double(i) < phase {
            line.append("X")
        } else {
            line.append("O")
        }
    }
    print(line, terminator: "")
    fflush(stdout)
}

@MainActor
func input(state: inout State) {
    let inChar: CChar = CChar(fgetc(stdin))

    let enabled = state.link.isEnabled

    switch Character(Unicode.Scalar(UInt8(inChar))) {
    case "q":
        state.running = false
        clearLine()
        return
    case "a":
        state.link.setActive(!enabled)
    case "w":
        state.link.appSessionState.tempo -= 1
    case "e":
        state.link.appSessionState.tempo += 1
    case "r":
        state.quantum -= 1
    case "t":
        state.quantum += 1
    case "s":
        state.link.isStartStopSyncEnabled = !state.link.isStartStopSyncEnabled
    case " ":
        var sessionState = state.link.appSessionState
        if sessionState.isPlaying {
            sessionState.isPlaying = false
        } else {
            sessionState.setPlaying(true, andRequestBeat: 0, quantum: state.quantum)
        }
        state.link.appSessionState = sessionState
    default:
        break
    }
}

@MainActor
func main() {
    var state = State()

    printHelp()
    printStateHeader()
    disableBufferedInput()

    while state.running {
        clearLine()
        if waitForInput() {
            input(state: &state)
        } else {
            print(state: state)
        }
    }

    enableBufferedInput()
}

// This shouldn't produce a warning (or require top-level await):
// https://github.com/swiftlang/swift/issues/73050
await main()
