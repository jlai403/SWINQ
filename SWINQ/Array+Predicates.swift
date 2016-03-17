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
    
    func count(predicate: (Element) -> Bool) -> Int {
        return self.all(predicate).count
    }
    
    func max<T: Numeric>(predicate: (Element) -> T) -> T {
        let maxValue = T()
        return self.select(predicate).reduce(maxValue) { (var maxValue, element) in
            maxValue = element > maxValue ? element : maxValue
            return maxValue
        }
    }
    
    func min<T: Numeric>(predicate: (Element) -> T) -> T {
        let elementList = self.select(predicate)
        let minValue:T = elementList.first != nil ? elementList.first! : T()
        return elementList.reduce(minValue) { (var minValue, element) in
            minValue = element < minValue ? element : minValue
            return minValue
        }
    }
    
    func average<T: Numeric>(predicate: (Element) -> T) -> Double {
        let elementList = self.select(predicate)
        if elementList.isEmpty { return Double() }
        let denominator = elementList.count
        let sum:T = elementList.sum()
        if let numerator = sum as? Int {
            return Double(numerator) / Double(denominator)
        }
        if let numerator = sum as? Float {
            return Double(numerator) / Double(denominator)
        }
        if let numerator = sum as? Double {
           
            return Double(numerator) / Double(denominator)
        }
        fatalError("numerator: '\(sum)' is not of type Numeric.")
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

extension Array where Element: Numeric {
    
    func sum<T: Numeric>() -> T {
        let total = T()
        return self.select{ $0 as! T }.reduce(total) { (total, element) in
            return total + element
        }
    }
}

