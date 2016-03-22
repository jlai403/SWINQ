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
        var array = [T]()
        
        self.forEach({ (element) in
            array.appendContentsOf(predicate(element))
        })
        
        return array
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
        var dictionary = [Key: Value]()
        self.forEach { (element) in
            let keyPair = predicate(element)
            dictionary[keyPair.key] = keyPair.value
            
        }
        return dictionary
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
        for i in count ..< self.count {
            array.append(self[i])
        }
        return array
    }
    
    func skipWhile(predicate: (Element) -> Bool) -> [Element] {
        var array = [Element]()
        
        var start = 0
        while !predicate(self[start]) {
            start += 1
        }
        
        for i in start ..< self.count {
            array.append(self[i])
        }
        
        return array
    }
    
    func count(predicate: (Element) -> Bool) -> Int {
        return self.all(predicate).count
    }
    
    func max<T: Numeric>(predicate: (Element) -> T) -> T {
        var max = T()
        
        self.select(predicate).forEach { (numeric) in
            max = numeric > max ? numeric : max
        }
        
        return max
    }
    
    func min<T: Numeric>(predicate: (Element) -> T) -> T {
        let elementList = self.select(predicate)
        var min:T = elementList.first != nil ? elementList.first! : T()
        
        elementList.forEach({ (numeric) in
            min = numeric < min ? numeric : min
        })
            
        return min
    }
    
    func average<T: Numeric>(predicate: (Element) -> T) -> Double {
        let elementList = self.select(predicate)
        if elementList.isEmpty { return Double() }
        let numerator:T = elementList.sum()
        let denominator = elementList.count
        return numerator / denominator
    }
}

extension Array where Element: Equatable {

    func distinct() -> [Element] {
        var distincts = [Element]()
        
        self.forEach { (equatable) in
            if !distincts.contains(equatable) {
                distincts.append(equatable)
            }
        }
        return distincts
    }
}

extension Array where Element: Numeric {
    
    func sum<T: Numeric>() -> T {
        let total = T()
        return self.select{ $0 as! T }.reduce(total) { (total, element) in
            return total + element
        }
    }
    
    func average() -> Double {
        if self.isEmpty { return Double() }
        let numerator: Element = self.sum()
        let denominator = self.count
        return numerator / denominator
    }
}

