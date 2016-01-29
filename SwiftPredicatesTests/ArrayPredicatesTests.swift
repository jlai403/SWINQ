
import XCTest
@testable import SwiftPredicates

class ArrayPredicatesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_firstOrDefault_String() {
        // assemble
        let expected = "Wubba lubba dub dub"
        let array = ["random", expected, "random"]
        
        // act
        let actual = array.firstOrDefault{ (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }
    
    func test_firstOrDefault_Multiple() {
        // assemble
        let array = [
            TestItem(num: 1, text: "Wubba lubba dub dub"),
            TestItem(num: 2, text: "Wubba lubba dub dub"),
            TestItem(num: 3, text: "Wubba lubba dub dub"),
            TestItem(num: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = array.firstOrDefault{ (ti) in ti.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(1, actual!.num)
        XCTAssertEqual("Wubba lubba dub dub", actual!.text)
    }
    
    func test_lastOrDefault_String() {
        // assemble
        let expected = "Wubba lubba dub dub"
        let array = ["random", expected, "random"]
        
        // act
        let actual = array.lastOrDefault{ (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }
    
    func test_lastOrDefault_Multiple() {
        // assemble
        let array = [
            TestItem(num: 1, text: "Wubba lubba dub dub"),
            TestItem(num: 2, text: "Wubba lubba dub dub"),
            TestItem(num: 3, text: "Wubba lubba dub dub"),
            TestItem(num: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = array.lastOrDefault{ (ti) in ti.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual!.num)
        XCTAssertEqual("Wubba lubba dub dub", actual!.text)
    }
}



