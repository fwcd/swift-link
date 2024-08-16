/// A snapshot of the Link session state.
public protocol LinkSessionStateProtocol {
    /// The tempo in beats per minute.
    var tempo: Double { get set }
    
    /// Whether the session is playing.
    var isPlaying: Bool { get set }

    /// The beat at the given time (by default: now) for the given quantum.
    func beat(at hostTime: UInt64, quantum: Double) -> Double
    
    /// Attempts to set the session to playing at the given time.
    mutating func setPlaying(_ isPlaying: Bool, at hostTime: UInt64)
    
    /// Attempts to set the tempo at the given time.
    mutating func setTempo(_ tempo: Double, at hostTime: UInt64)

    /// Attempts to map the beat to the given time.
    mutating func request(beat: Double, at hostTime: UInt64, quantum: Double)
    
    /// Force-remaps the beat to the given time.
    mutating func force(beat: Double, at hostTime: UInt64, quantum: Double)
}
