
import XCTest
@testable import SWINQ

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
            TestItem(int: 1, text: "Wubba lubba dub dub"),
            TestItem(int: 2, text: "Wubba lubba dub dub"),
            TestItem(int: 3, text: "Wubba lubba dub dub"),
            TestItem(int: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = array.firstOrDefault{ (ti) in ti.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(TestItem(int: 1, text: "Wubba lubba dub dub"), actual!)
    }
    
    func test_firstOrDefault_Default() {
        // assemble
        let array = [
            TestItem(int: 1, text: "Wubba lubba dub dub"),
            TestItem(int: 2, text: "Wubba lubba dub dub"),
            TestItem(int: 3, text: "Wubba lubba dub dub"),
            TestItem(int: 4, text: "Grass tastes bad")
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
            TestItem(int: 1, text: "Wubba lubba dub dub"),
            TestItem(int: 2, text: "Wubba lubba dub dub"),
            TestItem(int: 3, text: "Wubba lubba dub dub"),
            TestItem(int: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = array.lastOrDefault{ (ti) in ti.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(TestItem(int: 3, text: "Wubba lubba dub dub"), actual)
    }
    
    func test_lastOrDefault_Default() {
        // assemble
        let array = [
            TestItem(int: 1, text: "Wubba lubba dub dub"),
            TestItem(int: 2, text: "Wubba lubba dub dub"),
            TestItem(int: 3, text: "Wubba lubba dub dub"),
            TestItem(int: 4, text: "Grass tastes bad")
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
    
    func test_selectMany() {
        // assemble
        let array = [
            TestItem(array: "one", "two", "three"),
            TestItem(array: "four", "five", "six"),
            TestItem(array: "seven", "eight", "nine")
        ]
        
        // act
        let actual = array.selectMany { (x) in x.array }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(9, actual.count)
        XCTAssertEqual("one", actual[0])
        XCTAssertEqual("two", actual[1])
        XCTAssertEqual("three", actual[2])
        XCTAssertEqual("four", actual[3])
        XCTAssertEqual("five", actual[4])
        XCTAssertEqual("six", actual[5])
        XCTAssertEqual("seven", actual[6])
        XCTAssertEqual("eight", actual[7])
        XCTAssertEqual("nine", actual[8])
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
        let firstTestItem = TestItem(int: 1, text: "Wubba lubba dub dub")
        let secondTestItem = TestItem(int: 2, text: "Wubba lubba dub dub")
        let thirdTestItem = TestItem(int: 3, text: "Wubba lubba dub dub")
        let fourthTestItem = TestItem(int: 4, text: "Grass tastes bad")
        
        let array = [firstTestItem, secondTestItem, thirdTestItem, fourthTestItem]
        
        // act
        let dictionary = array.toDictionary { (ti) in
            return (key: ti.int, value: ti)
        }
        
        // assert
        XCTAssertNotNil(dictionary)
        XCTAssertEqual(4, dictionary.count)
        XCTAssertEqual(dictionary[1], firstTestItem)
        XCTAssertEqual(dictionary[2], secondTestItem)
        XCTAssertEqual(dictionary[3], thirdTestItem)
        XCTAssertEqual(dictionary[4], fourthTestItem)
    }
    
    func test_take() {
        // assemble
        let firstTestItem = TestItem(int: 1, text: "Wubba lubba dub dub")
        let secondTestItem = TestItem(int: 2, text: "Wubba lubba dub dub")
        let thirdTestItem = TestItem(int: 3, text: "Wubba lubba dub dub")
        let fourthTestItem = TestItem(int: 4, text: "Grass tastes bad")
        
        let array = [firstTestItem, secondTestItem, thirdTestItem, fourthTestItem]
        
        // act
        let actual = array.take(2)
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(2, actual.count)
        XCTAssertEqual(actual[0], firstTestItem)
        XCTAssertEqual(actual[1], secondTestItem)
    }
    
    func test_takeWhile() {
        // assemble
        let array = [1, 2, 3, 4, 3, 2, 1]
        
        // act
        let actual = array.takeWhile { (x) in x < 4 }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual.count)
        XCTAssertEqual(actual[0], 1)
        XCTAssertEqual(actual[1], 2)
        XCTAssertEqual(actual[2], 3)
    }
    
    func test_takeWhile_ignorePredicateAfterFirstPass() {
        // assemble
        let array = [1, 2, 3, 4, 3, 6, 1]
        
        // act
        let actual = array.takeWhile { (x) in x < 4 }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual.count)
        XCTAssertEqual(actual[0], 1)
        XCTAssertEqual(actual[1], 2)
        XCTAssertEqual(actual[2], 3)
    }
    
    func test_skip() {
        // assemble
        let array = [1, 2, 3, 4, 3, 2, 1]
        
        // act
        let actual = array.skip(3)
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(4, actual.count)
        XCTAssertEqual(actual[0], 4)
        XCTAssertEqual(actual[1], 3)
        XCTAssertEqual(actual[2], 2)
        XCTAssertEqual(actual[3], 1)
    }
    
    func test_skipWhile() {
        // assemble
        let array = [1, 2, 3, 4, 3, 2, 1]
        
        // act
        let actual = array.skipWhile{ (x) in x > 3 }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(4, actual.count)
        XCTAssertEqual(actual[0], 4)
        XCTAssertEqual(actual[1], 3)
        XCTAssertEqual(actual[2], 2)
        XCTAssertEqual(actual[3], 1)
    }
    
    func test_skipWhile_ignorePredicateAfterFirstPass() {
        // assemble
        let array = [1, 2, 3, 4, 5, 2, 7]
        
        // act
        let actual = array.skipWhile{ (x) in x > 3 }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(4, actual.count)
        XCTAssertEqual(actual[0], 4)
        XCTAssertEqual(actual[1], 5)
        XCTAssertEqual(actual[2], 2)
        XCTAssertEqual(actual[3], 7)
    }
    
    func test_distinct() {
        // assemble
        let array = [1, 2, 1, 2, 1, 2, 7]

        // act
        let actual = array.distinct()
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual.count)
        XCTAssertEqual(actual[0], 1)
        XCTAssertEqual(actual[1], 2)
        XCTAssertEqual(actual[2], 7)
    }
    
    func test_distinct_unordered() {
        // assemble
        let array = [7, 2, 1, 2, 1, 2, 7]

        // act
        let actual = array.distinct()
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual.count)
        XCTAssertEqual(actual[0], 7)
        XCTAssertEqual(actual[1], 2)
        XCTAssertEqual(actual[2], 1)
    }
    
    func test_count_predicate() {
        // assemble
        let array = [7, 2, 1, 2, 1, 2, 7]
        
        // act
        let actual = array.count { $0 == 7 }
        
        // assert
        XCTAssertEqual(2, actual)
    }
    
    func test_sum() {
        // assemble
        let array = [7, 2, 1, 2, 1, 2, 7]
        
        // act
        let actual:Int = array.sum()
        
        // assert
        XCTAssertEqual(22, actual)
    }
    
    func test_sum_double() {
        // assemble
        let array = [7.2, 2.3, 1.5, 2.5, 1.2, 2.3, 7.5]
        
        // act
        let actual:Double = array.sum()
        
        // assertmaxValue
        XCTAssertEqual(24.5, actual)
    }
    
    func test_max_int() {
        // assemble
        let firstTestItem = TestItem(int: 1, text: "Wubba lubba dub dub")
        let secondTestItem = TestItem(int: 5, text: "Wubba lubba dub dub")
        let thirdTestItem = TestItem(int: 10, text: "Wubba lubba dub dub")
        let fourthTestItem = TestItem(int: 7, text: "Grass tastes bad")
        
        let array = [firstTestItem, secondTestItem, thirdTestItem, fourthTestItem]
        
        // act
        let actual = array.max { (x) in return x.int }
        
        // assert
        XCTAssertEqual(thirdTestItem.int, actual)
    }
    
    func test_max_double() {
        // assemble
        let firstTestItem = TestItem(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestItem = TestItem(double: 10.5, text: "Wubba lubba dub dub")
        let thirdTestItem = TestItem(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestItem = TestItem(double: 8.7, text: "Grass tastes bad")
        
        let array = [firstTestItem, secondTestItem, thirdTestItem, fourthTestItem]
        
        // act
        let actual = array.max { (x) in return x.double }
        
        // assert
        XCTAssertEqual(secondTestItem.double, actual)
    }
}



