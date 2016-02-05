import Foundation

extension Array {
    
    public func lastIndex() -> Int {
        return self.count - 1
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        for index in lastIndex().stride(through: 0, by: -1) {
            if self[index] == object {
                self.removeAtIndex(index)
            }
        }
    }
}


protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    init()
}

extension Int: Addable {}
extension Float: Addable {}
extension Double: Addable {}