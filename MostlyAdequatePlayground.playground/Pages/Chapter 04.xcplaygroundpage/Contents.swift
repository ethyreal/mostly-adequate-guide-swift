//: [Previous](@previous)

import Foundation

/*:
 Chapter 04: Currying
 
 Can't Live If Livin' Is without You
 */

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}

/*:
 Exercises
 */


//MARK:- Ex A

func split(_ seperator:Character, _ value:String) -> [Substring] {
    return value.split(separator: seperator)
}

// Refactor to remove all arguments by partially applying the function.
// words :: String -> [String]
let words = { (value:String) in
    return split(" ", value)
}

words("once upon a time")


// Solution:
let splitter = curry(split)

// words :: String -> [String]
let words2 = splitter(" ")

words2("once upon a time")


//MARK:- Ex C

// Considering the following function:
//
//   const keepHighest = (x, y) => (x >= y ? x : y);
//
// Refactor `max` to not reference any arguments using the helper function `keepHighest`.

// max :: [Number] -> Number
let max = { (numbers:[Int]) in
    return numbers.reduce(0, { (result, number) in
        return result >= number
            ? result
            : number
    })
}

max([34, 53, 21])


let keepHighest = { (x:Int, y:Int) in x >= y ? x : y }

keepHighest(12, 13)
keepHighest(13, 12)

let max2 = { (numbers:[Int]) in
    return numbers.reduce(0, keepHighest)
}

max2([34, 53, 21])

//: [Next](@next)

