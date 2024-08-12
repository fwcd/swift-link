/// A high-level wrapper around the Ableton Link instance.
public protocol LinkManagerProtocol {
    associatedtype LinkSessionState: LinkSessionStateProtocol

    /// Captures or commits the session state from the main app thread.
    @MainActor
    var appSessionState: Self.LinkSessionState { get set }

    /// Captures or commits the session state from the audio thread.
    var audioSessionState: Self.LinkSessionState { get set }

    /// Whether Link is enabled by the user in the settings.
    var isEnabled: Bool { get }

    /// Whether the session is playing.
    var isPlaying: Bool { get set }

    /// Whether Link is connected to other peers.
    var isConnected: Bool { get }

    /// Whether start/stop sync is enabled by the user in the settings.
    var isStartStopSyncEnabled: Bool { get }

    init(initialBpm: Double)

    /// Activates/deactives Link.
    func setActive(_ isActive: Bool)
}

public extension LinkManagerProtocol {
    init() {
        self.init(initialBpm: 120)
    }
}
