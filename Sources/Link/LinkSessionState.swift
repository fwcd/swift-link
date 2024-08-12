#if os(iOS)
public typealias LinkSessionState = _iOSLinkSessionState
#else
public typealias LinkSessionState = _CrossPlatformLinkSessionState
#endif

