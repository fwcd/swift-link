#if os(iOS)
import Foundation
import CLinkKit

public struct _iOSLinkSessionState: LinkSessionStateProtocol {
    let linkRef: ABLLinkRef
    let sessionStateRef: ABLLinkSessionStateRef
    
    public var _tempo: Double {
        ABLLinkGetTempo(sessionStateRef)
    }
    
    public var _isPlaying: Bool {
        ABLLinkIsPlaying(sessionStateRef)
    }
    
    public func setPlaying(_ isPlaying: Bool, at micros: UInt64) {
        ABLLinkSetIsPlaying(sessionStateRef, isPlaying, Clock.shared.ticks(forMicros: micros))
    }
    
    public func setPlaying(_ isPlaying: Bool, at micros: UInt64, andRequestBeat beat: Double, quantum: Double) {
        ABLLinkSetIsPlayingAndRequestBeatAtTime(
            sessionStateRef,
            isPlaying,
            Clock.shared.ticks(forMicros: micros),
            beat,
            quantum
        )
    }
    
    public func setTempo(_ tempo: Double, at micros: UInt64) {
        ABLLinkSetTempo(sessionStateRef, tempo, Clock.shared.ticks(forMicros: micros))
    }
    
    public func beat(at micros: UInt64, quantum: Double) -> Double {
        ABLLinkBeatAtTime(sessionStateRef, Clock.shared.ticks(forMicros: micros), quantum)
    }
    
    public mutating func request(beat: Double, at micros: UInt64, quantum: Double) {
        ABLLinkRequestBeatAtTime(sessionStateRef, beat, Clock.shared.ticks(forMicros: micros), quantum)
    }
    
    public mutating func force(beat: Double, at micros: UInt64, quantum: Double) {
        ABLLinkForceBeatAtTime(sessionStateRef, beat, Clock.shared.ticks(forMicros: micros), quantum)
    }
}
#endif
