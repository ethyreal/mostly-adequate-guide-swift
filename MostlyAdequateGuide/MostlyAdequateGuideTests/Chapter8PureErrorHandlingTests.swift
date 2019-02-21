//
//  Chapter8PureErrorHandlingTests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/21/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest

class Chapter8PureErrorHandlingTests: XCTestCase {
}

enum Either<T, U> {
    case left(T)
    case right(U)

    func map<V>(_ transform:(U) -> V) -> Either<T, V> {
        switch self {
        case .left( let val):
            return .left(val)
        case .right( let val ):
            return .right( transform(val) )
        }
    }
}

extension Chapter8PureErrorHandlingTests {

    func testFunctor() {

        print(Either<String, String>.right("rain").map { "b\($0)" })
        // right("brain")

        print(Either<String, String>.left("rain").map { "It's gonna \($0), better bring your umbrella!" })
        // left("rain")

    }
}
