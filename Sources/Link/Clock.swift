#if os(iOS)
public typealias Clock = _iOSClock
#else
public typealias Clock = _CrossPlatformClock
#endif
