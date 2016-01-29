import Foundation

extension Array {
    
    mutating func remove <U: Equatable> (object: U) {
        let lastIndex = self.count - 1
        
        for index in lastIndex.stride(through: 0, by: -1) {
            if let element = self[index] as? U {
                if element == object {
                    self.removeAtIndex(index)
                }
            }
        }
    }
    
}