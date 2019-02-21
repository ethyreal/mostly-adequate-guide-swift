//
//  Chapter8OldMcDonaldHadEffectsTests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/21/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest
@testable import MostlyAdequateGuide

class Chapter8OldMcDonaldHadEffectsTests: XCTestCase {}

struct IO<T> {

    let value:() -> T

    static func of(_ value:T) -> IO<T> {
        return IO(value: { value })
    }

    func map<U>(_ transform:(T) -> U) -> IO<U> {
        let newValue:() -> U = compose(transform, value)
        return IO(value: newValue )
    }
}
