#if os(iOS)
import Foundation
import CLinkKit

public struct _iOSLinkSessionState: LinkSessionStateProtocol {
    let linkRef: ABLLinkRef
    let sessionStateRef: ABLLinkSessionStateRef
    
    public var tempo: Double {
        get { ABLLinkGetTempo(sessionStateRef) }
        set { ABLLinkSetTempo(sessionStateRef, newValue, mach_absolute_time()) }
    }
    
    public var isPlaying: Bool {
        get { ABLLinkIsPlaying(sessionStateRef) }
        set { ABLLinkSetIsPlaying(sessionStateRef, newValue, mach_absolute_time()) }
    }
    
    public func beat(at hostTime: UInt64 = mach_absolute_time(), quantum: Double) -> Double {
        ABLLinkBeatAtTime(sessionStateRef, hostTime, quantum)
    }
    
    public mutating func request(beat: Double, at hostTime: UInt64 = mach_absolute_time(), quantum: Double) {
        ABLLinkRequestBeatAtTime(sessionStateRef, beat, hostTime, quantum)
    }
    
    public mutating func force(beat: Double, at hostTime: UInt64 = mach_absolute_time(), quantum: Double) {
        ABLLinkForceBeatAtTime(sessionStateRef, beat, hostTime, quantum)
    }
}
#endif
