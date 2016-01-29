import Foundation

class TestItem: Equatable {
    
    var num: Int = 0
    var text: String = ""
    
    convenience init(num: Int, text: String) {
        self.init()
        self.num = num
        self.text = text
    }
    
}

func ==(lhs: TestItem, rhs: TestItem) -> Bool {
    return
        lhs.num == rhs.num &&
        lhs.text == rhs.text
}