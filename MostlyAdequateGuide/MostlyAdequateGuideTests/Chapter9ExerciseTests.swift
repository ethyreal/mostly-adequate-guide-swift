//
//  Chapter9ExerciseTests.swift
//  MostlyAdequateGuideTests
//
//  Created by George Webster on 2/22/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import XCTest

class Chapter9ExerciseTests: XCTestCase {

}

// Considering a User object as follow:

struct Street {
    let number:Int?
    let name:String?
}

struct Address {
    let street:Street?
}

struct User {
    let id:Int
    let name:String
    let address:Address?
}

let albert = User(id: 1,
                  name: "Albert",
                  address: Address(street: Street(number: 22, name: "Walnut St")))

//“Use `safeProp` and `map/join` or `chain` to safely get the street name when given a user
//// getStreetName :: User -> Maybe String
//const getStreetName = undefined;”

extension Chapter9ExerciseTests {

    func testExerciseA() {
        //“Use `safeProp` and `map/join` or `chain` to safely get the street name when given a user
        //// getStreetName :: User -> Maybe String
        //const getStreetName = undefined;”
        let streetName = { (user:User) -> String? in
            user.address
                .flatMap { $0.street }
                .flatMap { $0.name }
        }
        XCTAssertEqual("Walnut St",
                       streetName(albert))
    }
}
