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

    func map<U>(_ transform: @escaping (T) -> U) -> IO<U> {
        return IO<U>() {
            return transform(self.value())
        }
    }
}

extension Chapter8OldMcDonaldHadEffectsTests {

    func testFunctor() {

        XCTAssertEqual(
            IO.of(UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300)))
                .map { $0.bounds.midX }
                .value(),
            150.0)
    }
}
