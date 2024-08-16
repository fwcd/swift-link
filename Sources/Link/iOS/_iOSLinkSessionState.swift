#if os(iOS)
import Foundation
import CLinkKit

public struct _iOSLinkSessionState: LinkSessionStateProtocol {
    let linkRef: ABLLinkRef
    let sessionStateRef: ABLLinkSessionStateRef
    
    public var _tempo: Double {
        ABLLinkGetTempo(sessionStateRef)
    }
    
    public var _isPlaying: Bool {
        ABLLinkIsPlaying(sessionStateRef)
    }
    
    public func setPlaying(_ isPlaying: Bool, at hostTime: UInt64) {
        ABLLinkSetIsPlaying(sessionStateRef, isPlaying, hostTime)
    }
    
    public func setTempo(_ tempo: Double, at hostTime: UInt64) {
        ABLLinkSetTempo(sessionStateRef, tempo, hostTime)
    }
    
    public func beat(at hostTime: UInt64, quantum: Double) -> Double {
        ABLLinkBeatAtTime(sessionStateRef, hostTime, quantum)
    }
    
    public mutating func request(beat: Double, at hostTime: UInt64, quantum: Double) {
        ABLLinkRequestBeatAtTime(sessionStateRef, beat, hostTime, quantum)
    }
    
    public mutating func force(beat: Double, at hostTime: UInt64, quantum: Double) {
        ABLLinkForceBeatAtTime(sessionStateRef, beat, hostTime, quantum)
    }
}
#endif
