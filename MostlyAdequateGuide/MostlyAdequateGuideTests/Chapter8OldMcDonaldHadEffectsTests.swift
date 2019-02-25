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

    let unsafePerformIO:() -> T

    static func of(_ value:T) -> IO<T> {
        return IO(unsafePerformIO: { value })
    }

    func map<U>(_ transform: @escaping (T) -> U) -> IO<U> {
        return IO<U>() {
            return transform(self.unsafePerformIO())
        }
    }
}

extension Chapter8OldMcDonaldHadEffectsTests {

    func testFunctor() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        XCTAssertEqual(
            IO.of(view)
                .map { $0.bounds.midX }
                .unsafePerformIO(),
            150.0)

        XCTAssertEqual(
            IO.of(view)
                .map { $0.bounds.midY }
                .map { $0 / 2 }
                .unsafePerformIO(),
            75.0)
    }
}
