import Foundation

extension Array {
    
    func firstOrDefault(defaultValue: Element? = nil, predicate: (Element -> Bool)) -> Element? {
        var result = defaultValue
        let filteredList = filter(predicate)
        if let first = filteredList.first {
            result = first
        }
        return result
    }
    
    func lastOrDefault(defaultValue: Element? = nil, predicate: (Element -> Bool)) -> Element? {
        var result = defaultValue
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
        return self.map({ (element) in
            predicate(element)
        })
    }
    
    func any(predicate: (Element -> Bool)? = nil) -> Bool {
        var result: Bool
        
        if let predicate = predicate {
            result = self.firstOrDefault(predicate: predicate) != nil
        } else {
            result = !self.isEmpty
        }
        
        return result
    }
    
    func toArray() -> [Element] {
        let copy = self
        return copy
    }
    
    func toDictionary<Key: Hashable, Value>(predicate: (Element)->(key: Key, value: Value)) -> [Key: Value] {
        let dictionary = [Key: Value]()
        
        return self.reduce(dictionary) { (var dictionary, element) in
            let keyPair = predicate(element)
            dictionary[keyPair.key] = keyPair.value
            return dictionary
        }
    }
}