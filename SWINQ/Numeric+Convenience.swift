import Foundation

protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    init()
}

protocol Numeric: Addable, Comparable {
    init()
}


extension Int: Numeric {}
extension Float: Numeric {}
extension Double: Numeric {}
