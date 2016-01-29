
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
        XCTAssertEqual(TestItem(num: 1, text: "Wubba lubba dub dub"), actual!)
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
        XCTAssertEqual(TestItem(num: 3, text: "Wubba lubba dub dub"), actual)
    }
    
    func test_all() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad",
        ]
        
        // act
        let actual = array.all { (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertEqual(2, actual.count)
    }
    
    func test_all_emptyList() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad",
        ]
        
        // act
        let actual = array.all { (x) in x == "Nothing" }
        
        // assert
        XCTAssertTrue(actual.isEmpty)
    }
    
    func test_select() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad",
        ]
        
        // act
        let actual = array.select { (x) in
            return TestItem(text: x)
        } as! [TestItem]
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(4, actual.count)
        XCTAssertEqual(TestItem(text: "Wubba lubba dub dub"), actual[0])
        XCTAssertEqual(TestItem(text: "Wubba lubba dub dub"), actual[1])
        XCTAssertEqual(TestItem(text: "Grass tastes bad"), actual[2])
        XCTAssertEqual(TestItem(text: "Grass tastes bad"), actual[3])
    }
}



