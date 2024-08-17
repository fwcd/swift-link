#if os(iOS)
import Foundation

public struct _iOSClock: ClockProtocol {
    public static let shared = _iOSClock()
    private let ticksPerMicro: UInt64
    
    public var micros: UInt64 {
        micros(forTicks: mach_absolute_time())
    }

    public init() {
        var timeInfo = mach_timebase_info_data_t(numer: 0, denom: 0)
        mach_timebase_info(&timeInfo)
        ticksPerMicro = UInt64(timeInfo.numer) / UInt64(timeInfo.denom * 1000)
    }

    public func ticks(forMicros micros: UInt64) -> UInt64 {
        micros * ticksPerMicro
    }

    public func micros(forTicks ticks: UInt64) -> UInt64 {
        ticks / ticksPerMicro
    }
}
#endif
