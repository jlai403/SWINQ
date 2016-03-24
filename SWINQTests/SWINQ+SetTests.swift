
import XCTest
@testable import SWINQ

class SWINQSetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_firstOrDefault_String() {
        // assemble
        let expected = "Wubba lubba dub dub"
        let set: Set = ["random", expected, "Grass..tastes bad"]
        
        // act
        let actual = set.firstOrDefault{ (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }
    
    func test_firstOrDefault_Multiple() {
        // assemble
        let set: Set = [
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = set.firstOrDefault{ (te) in te.int == 1 && te.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(TestElement(int: 1, text: "Wubba lubba dub dub"), actual!)
    }
    
    func test_firstOrDefault_Default() {
        // assemble
        let set: Set = [
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        let defaultValue = TestElement(text: "Default value")
        
        // act
        let actual = set.firstOrDefault(defaultValue){ (ti) in ti.text == "Nothing" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(defaultValue, actual!)
    }
    
    func test_lastOrDefault_String() {
        // assemble
        let expected = "Wubba lubba dub dub"
        let set = ["random", expected, "random"]
        
        // act
        let actual = set.lastOrDefault{ (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }
    
    func test_lastOrDefault_Multiple() {
        // assemble
        let set: Set = [
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = set.lastOrDefault{ (te) in te.int == 3 && te.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(TestElement(int: 3, text: "Wubba lubba dub dub"), actual)
    }
    
    func test_lastOrDefault_Default() {
        // assemble
        let set: Set = [
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        let defaultValue = TestElement(text: "Default value")
        
        // act
        let actual = set.lastOrDefault(defaultValue){ (ti) in ti.text == "Nothing" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(defaultValue, actual!)
    }
    
    func test_all() {
        // assemble
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set.all { (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertEqual(1, actual.count)
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
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set
            .all{ (x) in x == "Wubba lubba dub dub" }
            .select{ (x) in return TestElement(text: x) }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(1, actual.count)
        XCTAssertEqual(TestElement(text: "Wubba lubba dub dub"), actual[0])
    
    }
    
    func test_all_select_anyChain() {
        // assemble
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set
            .all{ (x) in x == "Wubba lubba dub dub" }
            .select{ (x) in return TestElement(text: x) }
            .any { (x) in x.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertTrue(actual)
    }
    
    
    func test_all_select_anyChain_empty() {
        // assemble
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set
            .all{ (x) in x == "Wubba lubba dub dub" }
            .select{ (x) in return TestElement(text: x) }
            .any { (x) in x.text == "Grass tastes bad" }
        
        // assert
        XCTAssertFalse(actual)
    }
    
    func test_select() {
        // assemble
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set.select { (x) in return TestElement(text: x) }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(2, actual.count)
        XCTAssertTrue(actual.contains(TestElement(text: "Wubba lubba dub dub")))
        XCTAssertTrue(actual.contains(TestElement(text: "Grass tastes bad")))
    }
    
    func test_selectMany() {
        // assemble
        let set: Set = [
            TestElement(array: "one", "two", "three"),
            TestElement(array: "four", "five", "six"),
            TestElement(array: "seven", "eight", "nine")
        ]
        
        // act
        let actual = set.selectMany { (x) in x.array }
        
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
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set.any()
        
        // assert
        XCTAssertTrue(actual)
    }
    
    func test_any_empty() {
        // assemble
        let set: Set<TestElement> = []
        
        // act
        let actual = set.any()
        
        // assert
        XCTAssertFalse(actual)
    }
    
    func test_any_predicate() {
        // assemble
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub",
            "Grass tastes bad",
            "Grass tastes bad"
        ]
        
        // act
        let actual = set.any { (x) in x == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertTrue(actual)
    }
    
    func test_any_predicate_empty() {
        // assemble
        let set: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub"
        ]
        
        // act
        let actual = set.any { (x) in x == "Grass tastes bad" }
        
        // assert
        XCTAssertFalse(actual)
    }
    
    func test_toArray() {
        let original: Set = [
            "Wubba lubba dub dub",
            "Wubba lubba dub dub"
        ]
        
        // act
        var copy = original.toArray()
        copy.append("Grass tastes bad")
        
        // assert
        XCTAssertEqual(2, copy.count)
        XCTAssertEqual(1, original.count)
    }
    
    func test_toDictionary() {
        // assemble
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 2, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 3, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 4, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let dictionary = set.toDictionary { (ti) in
            return (key: ti.int, value: ti)
        }
        
        // assert
        XCTAssertNotNil(dictionary)
        XCTAssertEqual(4, dictionary.count)
        XCTAssertEqual(dictionary[1], firstTestElement)
        XCTAssertEqual(dictionary[2], secondTestElement)
        XCTAssertEqual(dictionary[3], thirdTestElement)
        XCTAssertEqual(dictionary[4], fourthTestElement)
    }
    
    func test_take() {
        // assemble
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 2, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 3, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 4, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.take(2)
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(2, actual.count)
    }
    
    func test_takeWhile() {
        // assemble
        let set: Set = [1, 2, 3, 4, 3, 2, 1]
        
        // act
        let condition = { (x) in x < 4 }
        let actual = set.takeWhile { (x) in condition(x) }
    
        // assert
        XCTAssertNotNil(actual)
        
        var expectedCount = 0
        for val in set {
            if condition(val) {
                expectedCount += 1
            } else {
                break
            }
            
        }
        
        XCTAssertEqual(expectedCount, actual.count)
    }
    
    func test_skip() {
        // assemble
        let set: Set = [1, 2, 3, 4, 3, 2, 1]
        
        // act
        let actual = set.skip(3)
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(1, actual.count)
    }
    
    func test_skipWhile() {
        // assemble
        let set: Set = [1, 2, 3, 4, 3, 2, 1]
        
        // act
        let condition = { (x) in x > 3 }
        let actual = set.skipWhile{ (x) in condition(x) }
        
        // assert
        XCTAssertNotNil(actual)
        
        var skippedCount = 0
        for val in set {
            if condition(val) { break }
            skippedCount += 1
        }
        
        let expectedCount = set.count - skippedCount
        XCTAssertEqual(expectedCount, actual.count)
    }
    
    func test_skipWhile_ignorePredicateAfterFirstPass() {
        // assemble
        let set: Set = [1, 2, 3, 4, 5, 2, 7]
        
        // act
        let condition = { (x) in x > 3 }
        let actual = set.skipWhile{ (x) in condition(x) }
        
        // assert
        XCTAssertNotNil(actual)
        
        var skippedCount = 0
        for val in set {
            if condition(val) { break }
            skippedCount += 1
        }
        
        let expectedCount = set.count - skippedCount
        
        XCTAssertEqual(expectedCount, actual.count)
    }
    
    func test_distinct() {
        // assemble
        let set: Set = [1, 2, 1, 2, 1, 2, 7]
        
        // act
        let actual = set.distinct()
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual.count)
        XCTAssertTrue(actual.contains(1))
        XCTAssertTrue(actual.contains(2))
        XCTAssertTrue(actual.contains(7))
    }
    
    func test_distinct_unordered() {
        // assemble
        let array = [7, 2, 1, 2, 1, 2, 7]
        
        // act
        let actual = array.distinct()
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(3, actual.count)
        XCTAssertTrue(actual.contains(1))
        XCTAssertTrue(actual.contains(2))
        XCTAssertTrue(actual.contains(7))
    }
    
    func test_count_predicate() {
        // assemble
        let set: Set = [7, 2, 1, 2, 1, 2, 7]
        
        // act
        let actual = set.count { $0 == 7 }
        
        // assert
        XCTAssertEqual(1, actual)
    }
    
    func test_sum() {
        // assemble
        let set: Set = [7, 2, 1, 2, 1, 2, 7]
        
        // act
        let actual:Int = set.sum()
        
        // assert
        XCTAssertEqual(10, actual)
    }
    
    func test_sum_double() {
        // assemble
        let set: Set = [7.2, 2.3, 1.5, 2.5, 1.2, 2.3, 7.5]
        
        // act
        let actual:Double = set.sum()
        
        // assertmaxValue
        XCTAssertEqual(22.2, actual)
    }
    
    func test_sum_negatives() {
        // assemble
        let set: Set = [7, -2, 1, 2, 1, 2, 7, -7]
        
        // act
        let actual:Int = set.sum()
        
        // assert
        XCTAssertEqual(1, actual)
    }
    
    func test_sum_double_negative() {
        // assemble
        let set: Set = [7.2, 2.3, 1.5, -1.5, 2.5, 1.2, 2.3, 7.5, -7.5]
        
        // act
        let actual:Double = set.sum()
        
        // assert
        XCTAssertEqual(13.2, actual)
    }
    
    func test_max_predicate_int() {
        // assemble
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.max { (x) in return x.int }
        
        // assert
        XCTAssertEqual(thirdTestElement.int, actual)
    }
    
    func test_max_double() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 10.5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 8.7, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.max { (x) in return x.double }
        
        // assert
        XCTAssertEqual(secondTestElement.double, actual)
    }
    
    func test_max_int_multiple() {
        // assemble
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 10, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.max { (x) in return x.int }
        
        // assert
        XCTAssertEqual(10, actual)
    }
    
    func test_max_double_multple() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 10.5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 10.5, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.max { (x) in return x.double }
        
        // assert
        XCTAssertEqual(10.5, actual)
    }
    
    func test_min_int() {
        // assemble
        let firstTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(thirdTestElement.int, actual)
    }
    
    func test_min_double() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 1.0, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 8.7, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(secondTestElement.double, actual)
    }
    
    func test_min_int_multiple() {
        // assemble
        let firstTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(1, actual)
    }
    
    func test_min_double_multiple() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 1.0, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 1.0, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(1.0, actual)
    }
    
    func test_min_int_negative() {
        // assemble
        let firstTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: -5, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(-5, actual)
    }
    
    func test_min_double_negative() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 1.0, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: -1.0, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(-1.0, actual)
    }
    
    func test_min_int_empty() {
        // assemble
        let set: Set<TestElement> = []
        
        // act
        let actual = set.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(0, actual)
    }
    
    func test_min_double_empty() {
        // assemble
        let set: Set<TestElement> = []
        
        // act
        let actual = set.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.0, actual)
    }
    
    func test_average_predicate_double() {
        // assemble
        let firstTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 0.25, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.average { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_predicate_double_differentValues() {
        // assemble
        let firstTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 0.26, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 0.27, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 0.28, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.average { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.265, actual.roundTo(3))
    }
    
    func test_average_double() {
        // assemble
        let set: Set = [0.25, 0.25, 0.25, 0.25]
        
        // act
        let actual = set.average()
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_double_differentValues() {
        // assemble
        let set: Set = [0.25, 0.26, 0.27, 0.28]
        
        // act
        let actual = set.average()
        
        // assert
        XCTAssertEqual(0.265, actual)
    }
    
    func test_average_float() {
        // assemble
        let firstTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(float: 0.25, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.average { (x) in return x.float }
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_float_differentVaues() {
        // assemble
        let firstTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(float: 0.26, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(float: 0.27, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(float: 0.28, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.average { (x) in return x.float }
        
        // assert
        XCTAssertEqual(0.265, actual.roundTo(3))
    }
    
    func test_average_predicate_int() {
        // assemble
        let firstTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 25, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.average { (x) in return x.int }
        
        // assert
        XCTAssertEqual(25, actual)
    }
    
    func test_average_predicate_int_differentValues() {
        // assemble
        let firstTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 26, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 27, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 28, text: "Grass tastes bad")
        
        let set: Set = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = set.average { (x) in return x.int }
        
        // assert
        XCTAssertEqual(26.5, actual)
    }
    
    func test_average_int() {
        // assemble
        let set: Set = [25, 25, 25, 25]
        
        // act
        let actual = set.average()
        
        // assert
        XCTAssertEqual(25, actual)
    }
    
    func test_average_int_differentValues() {
        // assemble
        let set: Set = [25, 26, 27, 28]
        
        // act
        let actual = set.average()
        
        // assert
        XCTAssertEqual(26.5, actual)
    }
    
    func test_average_empty() {
        // assemble
        let set: Set<Int> = []
        
        // act
        let actual = set.average()
        
        // assert
        XCTAssertEqual(0.0, actual)
    }
    
    func test_average_predicate_empty() {
        // assemble
        let set: Set<TestElement> = []
        
        // act
        let actual = set.average { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.0, actual)
    }
}



