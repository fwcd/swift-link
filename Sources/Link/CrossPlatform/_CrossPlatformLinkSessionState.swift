#if !os(iOS)
import CxxLink

public final class _CrossPlatformLinkSessionState: LinkSessionStateProtocol {
    let sessionStateInstance: abl_link_session_state
    
    public var tempo: Double {
        get { abl_link_tempo(sessionStateInstance) }
        set { fatalError("TODO") }
    }
    
    public var isPlaying: Bool {
        get { abl_link_is_playing(sessionStateInstance) }
        set { fatalError("TODO") }
    }
    
    init() {
        sessionStateInstance = abl_link_create_session_state()
    }
    
    deinit {
        abl_link_destroy_session_state(sessionStateInstance)
    }
    
    public func setPlaying(_ isPlaying: Bool, at hostTime: UInt64) {
        abl_link_set_is_playing(sessionStateInstance, isPlaying, hostTime)
    }
    
    public func setTempo(_ tempo: Double, at hostTime: UInt64) {
        abl_link_set_tempo(sessionStateInstance, tempo, Int64(hostTime))
    }

    public func beat(at hostTime: UInt64, quantum: Double) -> Double {
        abl_link_beat_at_time(sessionStateInstance, Int64(hostTime), quantum)
    }
    
    public func request(beat: Double, at hostTime: UInt64, quantum: Double) {
        abl_link_request_beat_at_time(sessionStateInstance, beat, Int64(hostTime), quantum)
    }
    
    public func force(beat: Double, at hostTime: UInt64, quantum: Double) {
        abl_link_force_beat_at_time(sessionStateInstance, beat, hostTime, quantum)
    }
}
#endif
