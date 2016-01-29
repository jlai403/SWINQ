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
}