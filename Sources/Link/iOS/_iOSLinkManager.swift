#if os(iOS)
import Foundation
import CLinkKit
import Observation

@Observable public final class _iOSLinkManager: LinkManagerProtocol {
    private(set) var linkRef: ABLLinkRef
    
    @MainActor
    public var appSessionState: LinkSessionState {
        get { LinkSessionState(linkRef: linkRef, sessionStateRef: ABLLinkCaptureAppSessionState(linkRef)) }
        set { ABLLinkCommitAppSessionState(linkRef, newValue.sessionStateRef) }
    }
    
    public var audioSessionState: LinkSessionState {
        get { LinkSessionState(linkRef: linkRef, sessionStateRef: ABLLinkCaptureAudioSessionState(linkRef)) }
        set { ABLLinkCommitAudioSessionState(linkRef, newValue.sessionStateRef) }
    }
    
    public var isEnabled: Bool {
        ABLLinkIsEnabled(linkRef)
    }
    
    public var isConnected: Bool {
        ABLLinkIsConnected(linkRef)
    }
    
    public var isStartStopSyncEnabled: Bool {
        ABLLinkIsStartStopSyncEnabled(linkRef)
    }
    
    public init(initialBpm: Double) {
        linkRef = ABLLinkNew(initialBpm)
    }
    
    deinit {
        ABLLinkDelete(linkRef)
    }
    
    public func setActive(_ isActive: Bool) {
        ABLLinkSetActive(linkRef, isActive)
    }
}
#endif
