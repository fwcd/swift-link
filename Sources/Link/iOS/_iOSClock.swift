#if os(iOS)
import Foundation

public struct _iOSClock: ClockProtocol {
    public static let shared = _iOSClock()
    
    public var hostTime: UInt64 {
        mach_absolute_time()
    }
}
#endif
