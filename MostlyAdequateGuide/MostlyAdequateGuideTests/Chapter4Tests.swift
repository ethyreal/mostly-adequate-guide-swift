//
//  Chapter4Tests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest
@testable import MostlyAdequateGuide

class Chapter4Tests: XCTestCase {


    func testExerciseA() {

        // Refactor to remove all arguments by partially applying the function.
        // words :: String -> [String]
        let words = { (value:String) in
            return split(" ", value)
        }

        let expected = words("once upon a time")

        // Solution:
        let splitter = curry(split)

        // words :: String -> [String]
        let words2 = splitter(" ")

        let actual = words2("once upon a time")

        XCTAssertEqual(expected, actual)
        XCTAssertEqual(actual, ["once", "upon", "a", "time"])
    }

    func testExceriseB() {

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

        let keepHighest = { (x:Int, y:Int) in x >= y ? x : y }

        XCTAssertEqual(13, keepHighest(12, 13))
        XCTAssertEqual(13, keepHighest(13, 12))

        let max2 = { (numbers:[Int]) in
            return numbers.reduce(0, keepHighest)
        }

        XCTAssertEqual(max([34, 53, 21]),
                       max2([34, 53, 21]))
        XCTAssertEqual(53,
                       max2([34, 53, 21]))

    }
}
