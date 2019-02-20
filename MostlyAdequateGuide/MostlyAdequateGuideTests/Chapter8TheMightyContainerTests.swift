//
//  Chapter8TheMightyContainerTests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest
@testable import MostlyAdequateGuide

class Chapter8TheMightyContainerTests: XCTestCase {

}

//MARK:- The Mighty Container

struct Container<A> {

    let value:A

    static func of(_ value:A) -> Container<A> {
        return Container(value: value)
    }
}

extension Chapter8TheMightyContainerTests {

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


//MARK:- My First Functor

extension Container {

    // (a -> b) -> Container a -> Container b
    func map<B>(_ t:(A) -> B) -> Container<B> {
        return Container<B>.of(t(value))
    }
}

extension Chapter8TheMightyContainerTests {

    func testFunctor() {

        print(Container.of(2).map { $0 + 2 })
        // Container<Int>(value: 4)

        print(Container.of("flamethrowers").map { $0.uppercased() })
        // Container<String>(value: "FLAMETHROWERS")

        // Container.of('bombs').map(append(' away')).map(prop('length'));
        //TODO: update this to use point free style like source
        print(Container.of("bombs")
            .map { "\($0) away" }
            .map { $0.count })
        // Container<Int>(value: 10)
    }
}
