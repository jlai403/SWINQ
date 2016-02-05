import Foundation

extension Array {
    
    public func lastIndex() -> Int {
        return self.count - 1
    }
    
    mutating func remove <T: Equatable> (object: T) {
        for index in lastIndex().stride(through: 0, by: -1) {
            if let element = self[index] as? T {
                if element == object {
                    self.removeAtIndex(index)
                }
            }
        }
    }
}