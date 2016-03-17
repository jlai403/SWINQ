import Foundation

protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
}

protocol Multiplicable {
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
}

protocol Numeric: Addable, Multiplicable, Comparable {
    init()
}

extension Int: Numeric {}
extension Float: Numeric {}
extension Double: Numeric {}
