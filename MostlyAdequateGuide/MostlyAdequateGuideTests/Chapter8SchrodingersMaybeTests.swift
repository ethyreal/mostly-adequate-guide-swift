//
//  Chapter8SchrodingersMaybeTests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/21/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest

class Chapter8SchrodingersMaybeTests: XCTestCase {
}

//MARK:- Schrödinger's Maybe

enum Maybe<T>: ExpressibleByNilLiteral {
    case just(T)
    case nothing

    init(nilLiteral: ()) {
        self = .nothing
    }

    init() {
        self = .nothing
    }

    init(_ value:T) {
        self = .just(value)
    }

    func map<U>(_ transform: (T) -> U) -> Maybe<U> {
        switch self {
        case .just(let value):
            return Maybe<U>(transform(value))
        case .nothing:
            return .nothing
        }
    }
}

extension Chapter8SchrodingersMaybeTests {

    func testFunctor() {
        print(Maybe("Malkovich Malkovic").map { $0.contains("a") })
        //just(true)
        print(Maybe<String>().map { $0.contains("a") })
        //nothing

        let name:Maybe<String> = nil
        print(name.map { $0.contains("a") })
        //nothing

        print(Maybe(["name": "Boris"]).map{ $0["age"]})
        //just(nil)

        print(Maybe(["name": "Boris", "age": 38]).map{ $0["age"]})
        //just(Optional(38))
    }
}
