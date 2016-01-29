import Foundation

extension Array {
    
    func firstOrDefault(predicate: (Element -> Bool)) -> Element? {
        var result: Element?
        let filteredList = filter(predicate)
        if let first = filteredList.first {
            result = first
        }
        return result
    }
    
    func lastOrDefault(predicate: (Element -> Bool)) -> Element? {
        var result: Element?
        let filteredList = filter(predicate)
        if let last = filteredList.last {
            result = last
        }
        return result
    }
    
    func all(predicate: (Element -> Bool)) -> [Element] {
        return filter(predicate)
    }
    
    func select(predicate: (Element -> AnyObject)) -> [AnyObject] {
        var result: [AnyObject] = []
        
        for element in Array(self) {
            result.append(predicate(element))
        }
        
        return result
    }
    
    func any(predicate: (Element -> Bool)? = nil) -> Bool {
        var result: Bool
        
        if let predicate = predicate {
            result = self.firstOrDefault(predicate) != nil
        } else {
            result = !self.isEmpty
        }
        
        return result
    }
}