import Foundation

class TestElement: Equatable {
    
    var int: Int = 0
    var float: Float = 0.0
    var double: Double = 0.0
    var text: String = ""
    var array: [String] = []
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    convenience init(int: Int, text: String) {
        self.init(text: text)
        self.int = int
    }
    
    convenience init(double: Double, text: String) {
        self.init(text: text)
        self.double = double
    }
    
    convenience init(float: Float, text: String) {
        self.init(text: text)
        self.float = float
    }
    
    convenience init(int: Int, text: String, array: String...) {
        self.init(int: int, text: text)
        self.array = array
    }
    
    convenience init(array: String...) {
        self.init()
        self.array = array
    }
}

func ==(lhs: TestElement, rhs: TestElement) -> Bool {
    return
        lhs.int == rhs.int &&
        lhs.float == rhs.float &&
        lhs.double == rhs.double &&
        lhs.array == rhs.array &&
        lhs.text == rhs.text
}