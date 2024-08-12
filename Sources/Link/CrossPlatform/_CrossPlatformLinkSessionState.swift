public struct _CrossPlatformLinkSessionState: LinkSessionStateProtocol {
    public var tempo: Double {
        get { fatalError("TODO") }
        set { fatalError("TODO") }
    }
    
    public func beat(at hostTime: UInt64, quantum: Double) -> Double {
        fatalError("TODO")
    }
    
    public mutating func request(beat: Double, at hostTime: UInt64, quantum: Double) {
        fatalError("TODO")
    }
    
    public mutating func force(beat: Double, at hostTime: UInt64, quantum: Double) {
        fatalError("TODO")
    }
}
