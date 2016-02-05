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
    
    func select<T>(predicate: (Element -> T)) -> [T] {
        return self.map({ (element) in
            predicate(element)
        })
    }
    
    func selectMany<T>(predicate: (Element -> [T])) -> [T] {
        let array = [T]()

        return self.reduce(array) { (var array, element) in
            array.appendContentsOf(predicate(element))
            return array
        }
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
    
    func take(count: Int) -> [Element] {
        var array = [Element]()
        
        for (index, element) in self.enumerate() {
            if (index >= count) { break }
            array.append(element)
        }
        
        return array
    }
    
    func takeWhile(predicate: (Element) -> Bool) -> [Element] {
        var array = [Element]()
        
        for element in self {
            if (!predicate(element)) { break }
            array.append(element)
        }
        
        return array
    }
    
    func skip(count: Int) -> [Element] {
        var array = [Element]()
        for (var i=count; i<self.count; i++) {
            array.append(self[i])
        }
        return array
    }
    
    func skipWhile(predicate: (Element) -> Bool) -> [Element] {
        var array = [Element]()
        
        var start = 0
        while !predicate(self[start]) {
            start++
        }
        
        for (var i=start; i<self.count; i++) {
            array.append(self[i])
        }
        
        return array
    }
}

extension Array where Element: Equatable {

    func distinct() -> [Element] {
        let array = [Element]()
        return self.reduce(array, combine: { (var array, element) in
            if !array.contains(element) {
                array.append(element)
            }
            return array
        })
    }
}