/// A high-level wrapper around the Ableton Link instance.
public protocol LinkProtocol {
    associatedtype LinkSessionState: LinkSessionStateProtocol

    /// Captures or commits the session state from the main app thread.
    @MainActor
    var appSessionState: Self.LinkSessionState { get set }

    /// Captures or commits the session state from the audio thread.
    var audioSessionState: Self.LinkSessionState { get set }

    /// Whether Link is enabled by the user in the settings.
    var isEnabled: Bool { get }

    /// Whether Link is connected to other peers.
    var isConnected: Bool { get }

    /// Whether start/stop sync is enabled by the user in the settings.
    var isStartStopSyncEnabled: Bool { get set }

    init(initialBpm: Double)

    /// Activates/deactives Link.
    func setActive(_ isActive: Bool)
}

public extension LinkProtocol {
    init() {
        self.init(initialBpm: 120)
    }
}
