/// A high-level abstraction around the platform's time.
public protocol ClockProtocol {
    /// The shared clock instance.
    static var shared: Self { get }

    /// The current host time in ticks.
    var hostTime: UInt64 { get }
}
