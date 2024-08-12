#if os(iOS)
public typealias LinkManager = _iOSLinkManager
#else
public typealias LinkManager = _CrossPlatformLinkManager
#endif
