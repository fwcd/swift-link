#if os(iOS)
public typealias Link = _iOSLink
#else
public typealias Link = _CrossPlatformLink
#endif
