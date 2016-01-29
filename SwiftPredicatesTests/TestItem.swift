import Foundation

class TestItem: Equatable {
    
    var num: Int = 0
    var text: String = ""
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    convenience init(num: Int, text: String) {
        self.init(text: text)
        self.text = text
    }
}

func ==(lhs: TestItem, rhs: TestItem) -> Bool {
    return
        lhs.num == rhs.num &&
        lhs.text == rhs.text
}