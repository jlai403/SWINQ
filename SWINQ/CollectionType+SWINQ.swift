import Foundation

public extension CollectionType {
    
    func firstOrDefault(defaultValue: Generator.Element? = nil, predicate: (Generator.Element -> Bool)) -> Generator.Element? {
        var result = defaultValue
        let filteredList = filter(predicate)
        if let first = filteredList.first {
            result = first
        }
        
        return result
    }
    
    func lastOrDefault(defaultValue: Generator.Element? = nil, predicate: (Generator.Element -> Bool)) -> Generator.Element? {
        var result = defaultValue
        let filteredList = filter(predicate)
        if let last = filteredList.last {
            result = last
        }
        return result
    }
    
    func all(predicate: (Generator.Element -> Bool)) -> [Generator.Element] {
        return filter(predicate)
    }
    
    func select<T>(predicate: (Generator.Element -> T)) -> [T] {
        return self.map({ (element) in
            predicate(element)
        })
    }
    
    func selectMany<T>(predicate: (Generator.Element -> [T])) -> [T] {
        var array = [T]()
        
        self.forEach({ (element) in
            array.appendContentsOf(predicate(element))
        })
        
        return array
    }
    
    func any(predicate: (Generator.Element -> Bool)? = nil) -> Bool {
        var result: Bool
        
        if let predicate = predicate {
            result = self.firstOrDefault(predicate: predicate) != nil
        } else {
            result = !self.isEmpty
        }
        
        return result
    }
    
    func toArray() -> [Generator.Element] {
        return Array(self)
    }
    
    func toDictionary<Key: Hashable, Value>(predicate: (Generator.Element)->(key: Key, value: Value)) -> [Key: Value] {
        var dictionary = [Key: Value]()
        self.forEach { (element) in
            let keyPair = predicate(element)
            dictionary[keyPair.key] = keyPair.value
            
        }
        return dictionary
    }
    
    func take(count: Int) -> [Generator.Element] {
        var array: [Generator.Element] = []
        
        for (index, element) in self.enumerate() {
            if (index >= count) { break }
            array.append(element)
        }
        
        return array
    }
    
    func takeWhile(predicate: (Generator.Element) -> Bool) -> [Generator.Element] {
        var array: [Generator.Element] = []
        
        for element in self {
            if (!predicate(element)) { break }
            array.append(element)
        }
        
        return array
    }
    
    func skip(count: Int) -> [Generator.Element] {
        var array: [Generator.Element] = []
        var i = 0
        
        for element in self {
            if i < count {
                i += 1
                continue
            }
            array.append(element)
        }
        
        return array
    }
    
    func skipWhile(predicate: (Generator.Element) -> Bool) -> [Generator.Element] {
        var array: [Generator.Element] = []
        guard let startIndex = self.indexOf(predicate) else { return array }
    
        for i in startIndex ..< self.endIndex {
            array.append(self[i])
        }

        return array
    }
    
    func count(predicate: (Generator.Element) -> Bool) -> Int {
        return self.all(predicate).count
    }
    
    func max<T: Numeric>(predicate: (Generator.Element) -> T) -> T {
        var max = T()
        
        self.select(predicate).forEach { (numeric) in
            max = numeric > max ? numeric : max
        }
        
        return max
    }
    
    func min<T: Numeric>(predicate: (Generator.Element) -> T) -> T {
        let elementList = self.select(predicate)
        var min:T = elementList.first != nil ? elementList.first! : T()
        
        elementList.forEach({ (numeric) in
            min = numeric < min ? numeric : min
        })
            
        return min
    }
    
    func average<T: Numeric>(predicate: (Generator.Element) -> T) -> Double {
        let elementList = self.select(predicate)
        if elementList.isEmpty { return Double() }
        let numerator:T = elementList.sum()
        let denominator = elementList.count
        return numerator / denominator
    }
    
    func ofType<T>(type: T.Type) -> [T] {
        var result: [T] = []
        for element in self {
            if element is T {
                result.append(element as! T)
            }
        }
        return result
    }
}

extension CollectionType where Generator.Element: Equatable {

    func distinct() -> [Generator.Element] {
        var distincts: [Generator.Element] = []
        
        self.forEach { (equatable) in
            if !distincts.contains(equatable) {
                distincts.append(equatable)
            }
        }
        return distincts
    }
}

extension CollectionType where Generator.Element: Numeric {
    
    func sum<T: Numeric>() -> T {
        let total = T()
        return self.select{ $0 as! T }.reduce(total) { (total, element) in
            return total + element
        }
    }
    
    func average() -> Double {
        if self.isEmpty { return Double() }
        let numerator: Generator.Element = self.sum()
        let denominator = Int(self.count.toIntMax())
        return numerator / denominator
    }
}

