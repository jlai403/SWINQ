# SWINQ
[![Travis branch](https://img.shields.io/travis/jlai403/SWINQ/master.svg?style=flat-square)](https://travis-ci.org/jlai403/SWINQ)
[![Codecov branch](https://img.shields.io/codecov/c/github/jlai403/SWINQ/master.svg?style=flat-square)](https://codecov.io/github/jlai403/SWINQ?branch=master)
[![CocoaPods](https://img.shields.io/cocoapods/v/SWINQ.svg?style=flat-square)](https://cocoapods.org/pods/SWINQ)
[![GitHub license](https://img.shields.io/github/license/jlai403/SWINQ.svg?style=flat-square)](https://github.com/jlai403/SWINQ/blob/master/LICENSE)

## Intro

SWINQ is LINQ (Language Integrated Queries) for Swift 2.0. If you are unfamilar with [LINQ](https://msdn.microsoft.com/en-us/library/bb397926.aspx), it is a .NET Framework that provides powerful extension methods for querying and modifying data. These extension methods are not only handy to use, they also make your code much easier to read and consume by others.

The article "[Collection Pipeline](http://martinfowler.com/articles/collection-pipeline/)", written by [Martin Fowler](http://martinfowler.com), provides additional information about integrated queries at a higher level while providing many concrete examples/differences in how you would use integrated queries in other languages.


## Installation

### CocoaPods
You install SWINQ via [CocoaPods](https://cocoapods.org/) by adding the following line to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'SWINQ'
```

### Manual
If you do not use CocoaPods, you can add SWINQ to you projects manually by downloading the latest [release](https://github.com/jlai403/SWINQ/releases).

## Usage

##### `firstOrDefault` - returns the first element found in sequence given a predicate, or the default value if no elements found

```swift
[1,2,3,4].firstOrDefault{ (x) in x == 3 } // outputs 3
[1,2,3,4].firstOrDefault{ (x) in x%2 == 0 } // outputs 2
[1,2,3,4].firstOrDefault(0) { (x) in x == 4} //outputs 0
```

##### `lastOrDefault` - returns the last element found in sequence given a predicate, or the default value if no elements found

```swift
[1,2,3,4].lastOrDefault{ (x) in x == 3 } // outputs 3
[1,2,3,4].lastOrDefault{ (x) in x%2 == 0 } // outputs 4
[1,2,3,4].lastOrDefault(0) { (x) in x == 5} //outputs 0
```

##### `all` - returns all elements found in sequence given a predicate

```swift
[1,2,3,4].all{ (x) in x == 3 } // outputs [3]
[1,2,3,4].all{ (x) in x%2 == 0 } // outputs [2, 4]
[1,2,3,4].all{ (x) in x == 5} //outputs []
```

##### `select` - transforms each element in sequence into a new form

```swift
[1,2,3,4].select{ (x) in "\(x)" } // outputs ["1", "2", "3", "4"]
[1,2,3,4].select{ (x) in x * x } // outputs [1, 4, 9, 16]

```

##### `selectMany` - flattens collections

```swift
["hello", "world"].selectMany{(x) in Array(x.characters)} // outputs ["h","e","l","o","w","o","r","l","d"]

```

##### `any` - returns whether an element in sequence matches the given predicate

```swift
[1,2,3,4].any() // outputs true
[1,2,3,4].any{ (x) in x == 3 } // outputs true
[1,2,3,4].any{ (x) in x == 5 } // outputs false

```

##### `toArray` - creates a new array from the sequence

```swift
var original = [1,2,3,4]
var copy = original.toArray()
copy.append(5)

print(original) // outputs [1, 2, 3, 4]
print(copy) // outputs [1, 2, 3, 4, 5]

```

##### `toDictionary` - creates a new dictionary from the sequence

```swift
["hello","world"].toDictionary { (x) in
    return (key: x.characters.count, value: x)
}

// outputs [5: "hello", 6: "world!"]

```

##### `take` - returns the *x* number of elements starting from the beginning of the sequence

```swift
[1,2,3,4].take(1) // outputs [1]
[1,2,3,4].take(2) // outputs [1, 2]
[1,2,3,4].take(3) // outputs [1, 2, 3]

```

##### `takeWhile` - returns elements from the sequence until the given predicate fails

```swift
[1,2,3,4].takeWhile{ (x) in x < 0 } // outputs []
[1,2,3,4].takeWhile{ (x) in x < 3 } // outputs [1, 2]
[1,2,3,4].takeWhile{ (x) in x < 5 } // outputs [1, 2, 3, 4]

```

##### `skip` - skips *x* number of elements and returns the remaining sequence

```swift
[1,2,3,4].skip(1) // outputs [2, 3, 4]
[1,2,3,4].skip(2) // outputs [3, 4]
[1,2,3,4].skip(3) // outputs [4]

```

##### `skipWhile` - continues to skip elements until an element matches the given predicate

```swift
[1,2,3,4].skipWhile{ (x) in x > 1 } // outputs [2, 3, 4]
[1,2,3,4].skipWhile{ (x) in x > 3 } // outputs [4]
[1,2,3,4].skipWhile{ (x) in x > 5 } // outputs []

```

More coming soon...
