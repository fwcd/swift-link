#if !os(iOS)
import CxxLink

public final class _CrossPlatformClock: ClockProtocol {
    public static let shared = _CrossPlatformClock()

    private let clockInstance: abl_clock

    public var micros: UInt64 {
        abl_clock_micros(clockInstance)
    }

    public init() {
        clockInstance = abl_clock_create()
    }

    deinit {
        abl_clock_destroy(clockInstance)
    }
}
#endif
