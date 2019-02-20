//
//  Chapter8TheMightyContainerTests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest
@testable import MostlyAdequateGuide


struct Container<A> {

    let value:A

    static func of(_ value:A) -> Container<A> {
        return Container(value: value)
    }
}

class Chapter8TheMightyContainerTests: XCTestCase {


    func testContainer() {

        print(Container.of(42))
        // Container<Int>(value: 42)

        print(Container.of("hotdogs"))
        // Container<String>(value: "hotdogs")

        print(Container.of(Container.of(["name": "yoda"])))
        // Container<Container<Dictionary<String, String>>>(value: Container<Dictionary<String, String>>(value: ["name": "yoda"]))
        // More verbose with namespaces:
        // Container<Container<Dictionary<String, String>>>(value: MostlyAdequateGuideTests.Container<Swift.Dictionary<Swift.String, Swift.String>>(value: ["name": "yoda"]))


    }

}
