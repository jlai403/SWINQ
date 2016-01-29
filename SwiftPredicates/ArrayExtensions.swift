import Foundation

extension Array {
    
    public func lastIndex() -> Int {
        return self.count - 1
    }
    
    mutating func remove <U: Equatable> (object: U) {
        for index in lastIndex().stride(through: 0, by: -1) {
            if let element = self[index] as? U {
                if element == object {
                    self.removeAtIndex(index)
                }
            }
        }
    }
    
}