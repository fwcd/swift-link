#if !os(iOS)
import CxxLink

#if canImport(Observation)
import Observation
#endif

#if canImport(Observation)
@Observable
#endif
public final class _CrossPlatformLink: LinkProtocol {
    private let linkInstance: abl_link

    @MainActor
    public var appSessionState: LinkSessionState {
        get {
            let sessionState = LinkSessionState()
            abl_link_capture_app_session_state(linkInstance, sessionState.sessionStateInstance)
            return sessionState
        }
        set { abl_link_commit_app_session_state(linkInstance, newValue.sessionStateInstance) }
    }

    public var audioSessionState: LinkSessionState {
        get {
            let sessionState = LinkSessionState()
            abl_link_capture_audio_session_state(linkInstance, sessionState.sessionStateInstance)
            return sessionState
        }
        set { abl_link_commit_audio_session_state(linkInstance, newValue.sessionStateInstance) }
    }

    public var isEnabled: Bool {
        abl_link_is_enabled(linkInstance)
    }

    public var peerCount: Int {
        Int(abl_link_num_peers(linkInstance))
    }

    public var isConnected: Bool {
        isEnabled && peerCount > 0
    }

    public var isStartStopSyncEnabled: Bool {
        get { abl_link_is_start_stop_sync_enabled(linkInstance) }
        set { abl_link_enable_start_stop_sync(linkInstance, newValue) }
    }

    public init(initialBpm: Double) {
        linkInstance = abl_link_create(initialBpm)
    }

    deinit {
        abl_link_destroy(linkInstance)
    }

    public func setActive(_ isActive: Bool) {
        abl_link_enable(linkInstance, isActive)
    }
}
#endif
