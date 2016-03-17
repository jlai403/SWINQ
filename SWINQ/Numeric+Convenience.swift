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

extension Int: Numeric {}

func /(lhs: Int, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}

extension Float: Numeric {}

func /(lhs: Float, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}

extension Double: Numeric {}

func /(lhs: Double, rhs: Int) -> Double {
    return lhs / Double(rhs)
}
