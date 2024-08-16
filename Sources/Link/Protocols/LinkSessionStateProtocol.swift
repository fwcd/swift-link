/// A snapshot of the Link session state.
public protocol LinkSessionStateProtocol {
    /// The tempo in beats per minute.
    var _tempo: Double { get }
    
    /// Whether the session is playing.
    var _isPlaying: Bool { get }

    /// The beat at the given time (by default: now) for the given quantum.
    func beat(at micros: UInt64, quantum: Double) -> Double
    
    /// Attempts to set the session to playing at the given time.
    mutating func setPlaying(_ isPlaying: Bool, at micros: UInt64)

    /// Attempts to set the session to playing at the given time and requests
    /// the beat at the given time.
    mutating func setPlaying(_ isPlaying: Bool, at micros: UInt64, andRequestBeat beat: Double, quantum: Double)
    
    /// Attempts to set the tempo at the given time.
    mutating func setTempo(_ tempo: Double, at micros: UInt64)

    /// Attempts to map the beat to the given time.
    mutating func request(beat: Double, at micros: UInt64, quantum: Double)
    
    /// Force-remaps the beat to the given time.
    mutating func force(beat: Double, at micros: UInt64, quantum: Double)
}

public extension LinkSessionStateProtocol {
    /// The tempo in beats per minute.
    var tempo: Double {
        get { _tempo }
        set { setTempo(newValue) }
    }

    /// Whether the session is playing.
    var isPlaying: Bool {
        get { _isPlaying }
        set { setPlaying(newValue) }
    }

    /// Attempts to set the session to playing at the current time.
    mutating func setPlaying(_ isPlaying: Bool) {
        setPlaying(isPlaying, at: Clock.shared.micros)
    }

    /// Attempts to set the session to playing at the given time and requests
    /// the beat at the current time.
    mutating func setPlaying(_ isPlaying: Bool, andRequestBeat beat: Double, quantum: Double) {
        setPlaying(isPlaying, at: Clock.shared.micros, andRequestBeat: beat, quantum: quantum)
    }

    /// Attempts to set the tempo at the current time.
    mutating func setTempo(_ tempo: Double) {
        setTempo(tempo, at: Clock.shared.micros)
    }

    /// Attempts to map the beat to the current time.
    mutating func request(beat: Double, quantum: Double) {
        request(beat: beat, at: Clock.shared.micros, quantum: quantum)
    }
    
    /// Force-remaps the beat to the current time.
    mutating func force(beat: Double, quantum: Double) {
        force(beat: beat, at: Clock.shared.micros, quantum: quantum)
    }
}
