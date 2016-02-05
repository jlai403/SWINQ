import XCTest
@testable import SWINQ

class ArrayExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_remove() {
        // assemble
        var array = ["Wubba lubba dub dub"]
        
        // act
        array.remove("Wubba lubba dub dub")
        
        // assert
        XCTAssertTrue(array.isEmpty)
    }
    
    func test_remove_Multiple() {
        // assemble
        var array = ["Wubba lubba dub dub", "Grass tastes bad"]
        
        // act
        array.remove("Wubba lubba dub dub")
        
        // assert
        XCTAssertEqual(1, array.count)
    }
    
    func test_remove_MultipleRemoved() {
        // assemble
        var array = ["Wubba lubba dub dub", "Wubba lubba dub dub"]
        
        // act
        array.remove("Wubba lubba dub dub")
        
        // assert
        XCTAssertTrue(array.isEmpty)
    }
    
    func test_lastIndex() {
        // assemble
        let array = ["Wubba lubba dub dub", "Wubba lubba dub dub"]
        
        // act
        let actual = array.lastIndex()
        
        // assert
        XCTAssertEqual(1, actual)
    }
    
    func test_lastIndex_EmptyList() {
        // assemble
        let array: [AnyObject] = []
        
        // act
        let actual = array.lastIndex()
        
        // assert
        XCTAssertEqual(-1, actual)
    }
}