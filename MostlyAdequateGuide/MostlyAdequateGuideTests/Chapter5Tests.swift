//
//  Chapter5Tests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest
@testable import MostlyAdequateGuide

class Chapter5Tests: XCTestCase {

    // In each following exercise, we'll consider Car objects with the following shape:
    struct Car {
        let name: String
        let horsepower: Int
        let dollarValue: Int
        let isInStock: Bool
    }

    var cars = [Car]()

    override func setUp() {

        cars = [Car(name: "Honda Civic",
                    horsepower: 25,
                    dollarValue: 13000,
                    isInStock: false),
                Car(name: "Aston Martin One-77",
                    horsepower: 750,
                    dollarValue: 1850000,
                    isInStock: true)
        ]
    }

    func testExerciseA() {

        //Use `compose()` to rewrite the function below.

        // isLastInStock :: [Car] -> Boolean
        let isLastInStock = { (car:[Car]) -> Bool in
            let lastCar = car.last
            return lastCar?.isInStock
                ?? false
        }

        let path = \Car.isInStock

        func last2<A>(_ x:[A]) -> A? {
            return x.last
        }

        func isInStock(_ x:Car?) -> Bool {
            return x?.isInStock ?? false
        }

        let isLastInStock2 = isInStock <<< last2

        let cars = [Car(name: "Honda Civic",
                        horsepower: 25,
                        dollarValue: 13000,
                        isInStock: false),
                    Car(name: "Aston Martin One-77",
                        horsepower: 750,
                        dollarValue: 1850000,
                        isInStock: true)
        ]

        XCTAssert(isLastInStock2(cars))
    }


    func testExcersiseB() {

        // Considering the following function:
        //

        let average = { (xs:[Int]) in xs.reduce(0, +) / xs.count }

        //
        // Use the helper function `average` to refactor `averageDollarValue` as a composition."

        // averageDollarValue :: [Car] -> Int
        let averageDollarValue = { (cars:[Car]) -> Int in
            let dollarValues = cars.map { $0.dollarValue }
            return average(dollarValues)
        }

        let dollarValue = { (cars:[Car]) in cars.map { $0.dollarValue } }

        let averageDollarValue2 = average <<< dollarValue

        XCTAssertEqual(averageDollarValue(cars),
                       averageDollarValue2(cars))
        XCTAssertEqual(931500, averageDollarValue2(cars))
    }


    func testExcersiseC() {

        // Refactor `fastestCar` using `compose()` and other functions in pointfree-style.
        // Hint, the `flip` function may come in handy."

        let concat = { (a:String, b:String) in return a + b }

        // fastestCar :: [Car] -> String
        let fastestCar = { (cars:[Car]) -> String in
            let sorted = cars.sorted(by: { (a, b) -> Bool in
                return a.horsepower < b.horsepower
            })
            let fastest = last(sorted)!
            return "\(fastest.name) is the fastest"
        }
        fastestCar(cars)

    }
}
