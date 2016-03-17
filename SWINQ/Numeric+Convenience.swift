import Foundation

protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
}

protocol Multiplicable {
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    // Override for averages
    func /(lhs: Self, rhs: Int) -> Self
}

protocol Numeric: Addable, Multiplicable, Comparable {
    init()
}

extension Int: Numeric {}

extension Float: Numeric {}

func /(lhs: Float, rhs: Int) -> Float {
    return lhs / Float(rhs)
}

extension Double: Numeric {}

func /(lhs: Double, rhs: Int) -> Double {
    return lhs / Double(rhs)
}
