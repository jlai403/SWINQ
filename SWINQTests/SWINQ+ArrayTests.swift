
import XCTest
@testable import SWINQ

class SWINQArrayTests: XCTestCase {
    
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
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = array.firstOrDefault{ (ti) in ti.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(TestElement(int: 1, text: "Wubba lubba dub dub"), actual!)
    }
    
    func test_firstOrDefault_Default() {
        // assemble
        let array = [
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        let defaultValue = TestElement(text: "Default value")
        
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
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        // act
        let actual = array.lastOrDefault{ (ti) in ti.text == "Wubba lubba dub dub" }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(TestElement(int: 3, text: "Wubba lubba dub dub"), actual)
    }
    
    func test_lastOrDefault_Default() {
        // assemble
        let array = [
            TestElement(int: 1, text: "Wubba lubba dub dub"),
            TestElement(int: 2, text: "Wubba lubba dub dub"),
            TestElement(int: 3, text: "Wubba lubba dub dub"),
            TestElement(int: 4, text: "Grass tastes bad")
        ]
        
        let defaultValue = TestElement(text: "Default value")
        
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
            .select{ (x) in return TestElement(text: x) }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(2, actual.count)
        XCTAssertEqual(TestElement(text: "Wubba lubba dub dub"), actual[0])
        XCTAssertEqual(TestElement(text: "Wubba lubba dub dub"), actual[1])
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
            .select{ (x) in return TestElement(text: x) }
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
            .select{ (x) in return TestElement(text: x) }
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
        let actual = array.select { (x) in return TestElement(text: x) }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(4, actual.count)
        XCTAssertEqual(TestElement(text: "Wubba lubba dub dub"), actual[0])
        XCTAssertEqual(TestElement(text: "Wubba lubba dub dub"), actual[1])
        XCTAssertEqual(TestElement(text: "Grass tastes bad"), actual[2])
        XCTAssertEqual(TestElement(text: "Grass tastes bad"), actual[3])
    }
    
    func test_selectMany() {
        // assemble
        let array = [
            TestElement(array: "one", "two", "three"),
            TestElement(array: "four", "five", "six"),
            TestElement(array: "seven", "eight", "nine")
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
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 2, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 3, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 4, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let dictionary = array.toDictionary { (ti) in
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
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.take(2)
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(2, actual.count)
        XCTAssertEqual(actual[0], firstTestElement)
        XCTAssertEqual(actual[1], secondTestElement)
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
    
    func test_skipWhile_empty() {
        // assemble
        let array = [Int]()
        
        // act
        let actual = array.skipWhile{ (x) in x > 3 }
        
        // assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(0, actual.count)
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
    
    func test_sum_negatives() {
        // assemble
        let array = [7, -2, 1, 2, 1, 2, 7, -7]
        
        // act
        let actual:Int = array.sum()
        
        // assert
        XCTAssertEqual(11, actual)
    }
    
    func test_sum_double_negative() {
        // assemble
        let array = [7.2, 2.3, 1.5, -1.5, 2.5, 1.2, 2.3, 7.5, -7.5]
        
        // act
        let actual:Double = array.sum()
        
        // assertmaxValue
        XCTAssertEqual(15.5, actual)
    }
    
    func test_max_predicate_int() {
        // assemble
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.max { (x) in return x.int }
        
        // assert
        XCTAssertEqual(thirdTestElement.int, actual)
    }
    
    func test_max_double() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 10.5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 8.7, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.max { (x) in return x.double }
        
        // assert
        XCTAssertEqual(secondTestElement.double, actual)
    }
    
    func test_max_int_multiple() {
        // assemble
        let firstTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 10, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.max { (x) in return x.int }
        
        // assert
        XCTAssertEqual(10, actual)
    }
    
    func test_max_double_multple() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 10.5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 10.5, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.max { (x) in return x.double }
        
        // assert
        XCTAssertEqual(10.5, actual)
    }
    
    func test_min_int() {
        // assemble
        let firstTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 5, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(thirdTestElement.int, actual)
    }
    
    func test_min_double() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 1.0, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 8.7, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(secondTestElement.double, actual)
    }
    
    func test_min_int_multiple() {
        // assemble
        let firstTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(1, actual)
    }
    
    func test_min_double_multiple() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 1.0, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 1.0, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(1.0, actual)
    }
    
    func test_min_int_negative() {
        // assemble
        let firstTestElement = TestElement(int: 10, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 1, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: -5, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 7, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(-5, actual)
    }
    
    func test_min_double_negative() {
        // assemble
        let firstTestElement = TestElement(double: 1.1, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 1.0, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 10.1, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: -1.0, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(-1.0, actual)
    }
    
    func test_min_int_empty() {
        // assemble
        let array: [TestElement] = []
        
        // act
        let actual = array.min { (x) in return x.int }
        
        // assert
        XCTAssertEqual(0, actual)
    }
    
    func test_min_double_empty() {
        // assemble
        let array: [TestElement] = []
        
        // act
        let actual = array.min { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.0, actual)
    }
    
    func test_average_predicate_double() {
        // assemble
        let firstTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 0.25, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_predicate_double_differentValues() {
        // assemble
        let firstTestElement = TestElement(double: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(double: 0.26, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(double: 0.27, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(double: 0.28, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.265, actual.roundTo(3))
    }
    
    func test_average_double() {
        // assemble
        let array: [Double] = [0.25, 0.25, 0.25, 0.25]
        
        // act
        let actual = array.average()
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_double_differentValues() {
        // assemble
        let array: [Double] = [0.25, 0.26, 0.27, 0.28]
        
        // act
        let actual = array.average()
        
        // assert
        XCTAssertEqual(0.265, actual.roundTo(3))
    }
    
    func test_average_float() {
        // assemble
        let array: [Float] = [0.25, 0.25, 0.25, 0.25]
        
        // act
        let actual = array.average()
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_predicate_float() {
        // assemble
        let firstTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(float: 0.25, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.float }
        
        // assert
        XCTAssertEqual(0.25, actual)
    }
    
    func test_average_predicate_float_differentValues() {
        // assemble
        let firstTestElement = TestElement(float: 0.25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(float: 0.26, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(float: 0.27, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(float: 0.28, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.float }
        
        // assert
        XCTAssertEqual(0.265, actual.roundTo(3))
    }
    
    func test_average_predicate_int() {
        // assemble
        let firstTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 25, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.int }
        
        // assert
        XCTAssertEqual(25, actual)
    }
    
    func test_average_predicate_int_differentValue() {
        // assemble
        let firstTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 26, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 27, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 28, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.int }
        
        // assert
        XCTAssertEqual(26.5, actual.roundTo(1))
    }
    
    func test_average_int() {
        // assemble
        let array = [25, 25, 25, 25]
        
        // act
        let actual = array.average()
        
        // assert
        XCTAssertEqual(25, actual)
    }
    
    func test_average_int_differentValues() {
        // assemble
        let array = [25, 26, 27, 28]
        
        // act
        let actual = array.average()
        
        // assert
        XCTAssertEqual(26.5, actual.roundTo(1))
    }
    
    func test_average_int_resultIsDouble() {
        // assemble
        let firstTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let secondTestElement = TestElement(int: 25, text: "Wubba lubba dub dub")
        let thirdTestElement = TestElement(int: 26, text: "Wubba lubba dub dub")
        let fourthTestElement = TestElement(int: 26, text: "Grass tastes bad")
        
        let array = [firstTestElement, secondTestElement, thirdTestElement, fourthTestElement]
        
        // act
        let actual = array.average { (x) in return x.int }
        
        // assert
        XCTAssertEqual(25.5, actual)
    }
    
    func test_average_empty() {
        // assemble
        let array = [Int]()
        
        // act
        let actual = array.average()
        
        // assert
        XCTAssertEqual(0.0, actual)
    }
    
    func test_average_predicate_empty() {
        // assemble
        let array = [TestElement]()
        
        // act
        let actual = array.average { (x) in return x.double }
        
        // assert
        XCTAssertEqual(0.0, actual)
    }
}



