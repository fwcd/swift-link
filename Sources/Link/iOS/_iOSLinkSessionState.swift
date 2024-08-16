#if os(iOS)
import Foundation
import CLinkKit

public struct _iOSLinkSessionState: LinkSessionStateProtocol {
    let linkRef: ABLLinkRef
    let sessionStateRef: ABLLinkSessionStateRef
    
    public var tempo: Double {
        get { ABLLinkGetTempo(sessionStateRef) }
        set { setTempo(newValue) }
    }
    
    public var isPlaying: Bool {
        get { ABLLinkIsPlaying(sessionStateRef) }
        set { setPlaying(newValue) }
    }
    
    public func setPlaying(_ isPlaying: Bool, at hostTime: UInt64 = mach_absolute_time()) {
        ABLLinkSetIsPlaying(sessionStateRef, isPlaying, hostTime)
    }
    
    public func setTempo(_ tempo: Double, at hostTime: UInt64 = mach_absolute_time()) {
        ABLLinkSetTempo(sessionStateRef, tempo, hostTime)
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
