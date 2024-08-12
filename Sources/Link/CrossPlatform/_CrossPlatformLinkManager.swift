#if !os(iOS)
public struct _CrossPlatformLinkManager: LinkManagerProtocol {
    @MainActor
    public var appSessionState: LinkSessionState {
        get { fatalError("TODO") }
        set { fatalError("TODO") }
    }

    public var audioSessionState: LinkSessionState {
        get { fatalError("TODO") }
        set { fatalError("TODO") }
    }

    public var isEnabled: Bool {
        fatalError("TODO")
    }

    public var isPlaying: Bool {
        get { fatalError("TODO") }
        set { fatalError("TODO") }
    }

    public var isConnected: Bool {
        fatalError("TODO")
    }

    public var isStartStopSyncEnabled: Bool {
        fatalError("TODO")
    }

    public init(initialBpm: Double) {
        fatalError("TODO")
    }

    public func setActive(_ isActive: Bool) {
        fatalError("TODO")
    }
}
#endif
