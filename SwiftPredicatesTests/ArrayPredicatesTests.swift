
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
    
    func test_firstOrDefault_Default() {
        // assemble
        let array = [
            TestItem(num: 1, text: "Wubba lubba dub dub"),
            TestItem(num: 2, text: "Wubba lubba dub dub"),
            TestItem(num: 3, text: "Wubba lubba dub dub"),
            TestItem(num: 4, text: "Grass tastes bad")
        ]
        
        let defaultValue = TestItem(text: "Default value")
        
        // act
        let actual = array.firstOrDefault(defaultValue){ (ti) in ti.text == "Nothing" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(defaultValue, actual!)
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
    
    func test_lastOrDefault_Default() {
        // assemble
        let array = [
            TestItem(num: 1, text: "Wubba lubba dub dub"),
            TestItem(num: 2, text: "Wubba lubba dub dub"),
            TestItem(num: 3, text: "Wubba lubba dub dub"),
            TestItem(num: 4, text: "Grass tastes bad")
        ]
        
        let defaultValue = TestItem(text: "Default value")
        
        // act
        let actual = array.lastOrDefault(defaultValue){ (ti) in ti.text == "Nothing" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(defaultValue, actual!)
    }
    
    func test_all() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
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
            "Grass tastes bad"
        ]
        
        // act
        let actual = array.all { (x) in x == "Nothing" }
        
        // assert
        XCTAssertTrue(actual.isEmpty)
    }
    
    func test_all_select() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = array
            .all{ (x) in x == "Wubba lubba dub dub" }
            .select{ (x) in return TestItem(text: x) }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(2, actual.count)
        XCTAssertEqual(TestItem(text: "Wubba lubba dub dub"), actual[0])
        XCTAssertEqual(TestItem(text: "Wubba lubba dub dub"), actual[1])
    }
    
    func test_all_select_anyChain() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = array
            .all{ (x) in x == "Wubba lubba dub dub" }
            .select{ (x) in return TestItem(text: x) }
            .any { (x) in x.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertTrue(actual)
    }

    
    func test_all_select_anyChain_empty() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = array
            .all{ (x) in x == "Wubba lubba dub dub" }
            .select{ (x) in return TestItem(text: x) }
            .any { (x) in x.text == "Grass tastes bad" }
        
        // assert
        XCTAssertFalse(actual)
    }
    
    func test_select() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = array.select { (x) in return TestItem(text: x) }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(4, actual.count)
        XCTAssertEqual(TestItem(text: "Wubba lubba dub dub"), actual[0])
        XCTAssertEqual(TestItem(text: "Wubba lubba dub dub"), actual[1])
        XCTAssertEqual(TestItem(text: "Grass tastes bad"), actual[2])
        XCTAssertEqual(TestItem(text: "Grass tastes bad"), actual[3])
    }
    
    func test_any() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = array.any()
        
        // assert
        XCTAssertTrue(actual)
    }
    
    func test_any_empty() {
        // assemble
        let array: [AnyObject] = []
        
        // act
        let actual = array.any()
        
        // assert
        XCTAssertFalse(actual)
    }
    
    func test_any_predicate() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = array.any { (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertTrue(actual)
    }

    func test_any_predicate_empty() {
        // assemble
        let array = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub"
        ]
        
        // act
        let actual = array.any { (x) in x == "Grass tastes bad" }
        
        // assert
        XCTAssertFalse(actual)
    }

    func test_toArray() {
        let original = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub"
        ]
        
        // act
        var copy = original.toArray()
        copy.append("Grass tastes bad")
        
        // assert
        XCTAssertNotEqual(original, copy)
        XCTAssertEqual(3, copy.count)
        XCTAssertEqual(2, original.count)
    }
    
    func test_toDictionary() {
        // assemble
        let firstTestItem = TestItem(num: 1, text: "Wubba lubba dub dub")
        let secondTestItem = TestItem(num: 2, text: "Wubba lubba dub dub")
        let thirdTestItem = TestItem(num: 3, text: "Wubba lubba dub dub")
        let fourthTestItem = TestItem(num: 4, text: "Grass tastes bad")
        
        let array = [firstTestItem, secondTestItem, thirdTestItem, fourthTestItem]
        
        // act
        let dictionary = array.toDictionary { (ti) in
            return (key: ti.num, value: ti)
        }
        
        // assert
        XCTAssertNotNil(dictionary)
        XCTAssertEqual(4, dictionary.count)
        XCTAssertEqual(dictionary[1], firstTestItem)
        XCTAssertEqual(dictionary[2], secondTestItem)
        XCTAssertEqual(dictionary[3], thirdTestItem)
        XCTAssertEqual(dictionary[4], fourthTestItem)
    }
}



