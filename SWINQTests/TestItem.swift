import Foundation

class TestItem: Equatable {
    
    var num: Int = 0
    var text: String = ""
    var array: [String] = []
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    convenience init(num: Int, text: String) {
        self.init(text: text)
        self.num = num
    }
    
    convenience init(num: Int, text: String, array: String...) {
        self.init(num: num, text: text)
        self.array = array
    }
    
    convenience init(array: String...) {
        self.init()
        self.array = array
    }
}

func ==(lhs: TestItem, rhs: TestItem) -> Bool {
    return
        lhs.num == rhs.num &&
        lhs.text == rhs.text
}