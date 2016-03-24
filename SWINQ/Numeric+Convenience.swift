import Foundation

protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
}

protocol Multiplicable {
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    // Override for averages
    func /(lhs: Self, rhs: Int) -> Double
}

protocol Numeric: Addable, Multiplicable, Comparable {
    init()
}


// MARK: Int extensions
extension Int: Numeric {}

func /(lhs: Int, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}


// MARK: Float extensions
extension Float: Numeric { }

func /(lhs: Float, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}


// MARK: Double extension
protocol Precision {
    func roundTo(decimalPlaces: Int) -> Self
}

extension Double: Numeric, Precision {
    
    func roundTo(decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return round(self * divisor) / divisor
    }
}

func /(lhs: Double, rhs: Int) -> Double {
    return lhs / Double(rhs)
}
