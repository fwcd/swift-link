#if os(iOS)
import Foundation
import CLinkKit

/// A snapshot of the Link session state.
public struct _iOSLinkSessionState: LinkSessionStateProtocol {
    let linkRef: ABLLinkRef
    let sessionStateRef: ABLLinkSessionStateRef
    
    /// The tempo in beats per minute.
    public var tempo: Double {
        get { ABLLinkGetTempo(sessionStateRef) }
        set { ABLLinkSetTempo(sessionStateRef, newValue, mach_absolute_time()) }
    }
    
    /// The beat at the given time (by default: now) for the given quantum.
    public func beat(at hostTime: UInt64 = mach_absolute_time(), quantum: Double) -> Double {
        ABLLinkBeatAtTime(sessionStateRef, hostTime, quantum)
    }
    
    /// Attempts to map the beat to the given time.
    public mutating func request(beat: Double, at hostTime: UInt64 = mach_absolute_time(), quantum: Double) {
        ABLLinkRequestBeatAtTime(sessionStateRef, beat, hostTime, quantum)
    }
    
    /// Force-remaps the beat to the given time.
    public mutating func force(beat: Double, at hostTime: UInt64 = mach_absolute_time(), quantum: Double) {
        ABLLinkForceBeatAtTime(sessionStateRef, beat, hostTime, quantum)
    }
}
#endif
