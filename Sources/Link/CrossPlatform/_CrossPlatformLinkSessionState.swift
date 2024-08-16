#if !os(iOS)
import CxxLink

public final class _CrossPlatformLinkSessionState: LinkSessionStateProtocol {
    let sessionStateInstance: abl_link_session_state
    
    public var _tempo: Double {
        abl_link_tempo(sessionStateInstance)
    }
    
    public var _isPlaying: Bool {
        abl_link_is_playing(sessionStateInstance)
    }
    
    init() {
        sessionStateInstance = abl_link_create_session_state()
    }
    
    deinit {
        abl_link_destroy_session_state(sessionStateInstance)
    }
    
    public func setPlaying(_ isPlaying: Bool, at micros: UInt64) {
        abl_link_set_is_playing(sessionStateInstance, isPlaying, micros)
    }

    public func setPlaying(_ isPlaying: Bool, at micros: UInt64, andRequestBeat beat: Double, quantum: Double) {
        abl_link_set_is_playing_and_request_beat_at_time(
            sessionStateInstance,
            isPlaying,
            micros,
            beat,
            quantum
        )
    }
    
    public func setTempo(_ tempo: Double, at micros: UInt64) {
        abl_link_set_tempo(sessionStateInstance, tempo, Int64(micros))
    }

    public func beat(at micros: UInt64, quantum: Double) -> Double {
        abl_link_beat_at_time(sessionStateInstance, Int64(micros), quantum)
    }

    public func phase(at micros: UInt64, quantum: Double) -> Double {
        abl_link_phase_at_time(sessionStateInstance, Int64(micros), quantum)
    }
    
    public func request(beat: Double, at micros: UInt64, quantum: Double) {
        abl_link_request_beat_at_time(sessionStateInstance, beat, Int64(micros), quantum)
    }
    
    public func force(beat: Double, at micros: UInt64, quantum: Double) {
        abl_link_force_beat_at_time(sessionStateInstance, beat, micros, quantum)
    }
}
#endif
