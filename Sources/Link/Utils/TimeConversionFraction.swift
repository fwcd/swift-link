struct TimeConversionFraction {
    let numerator: UInt64
    let denominator: UInt64

    static func *(lhs: UInt64, rhs: Self) -> UInt64 {
        (lhs * rhs.numerator) / rhs.denominator
    }

    static func /(lhs: UInt64, rhs: Self) -> UInt64 {
        (lhs * rhs.denominator) / rhs.numerator
    }
}
