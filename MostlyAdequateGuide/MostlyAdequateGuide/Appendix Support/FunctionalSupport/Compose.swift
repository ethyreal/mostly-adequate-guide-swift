//
//  Compose.swift
//  MostlyAdequateGuide
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import Foundation

//MARK:- Backwards Composition

precedencegroup BackwardsComposition {
    associativity: left
}

infix operator <<<: BackwardsComposition

func <<< <A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}

func compose<A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { x in
        f(g(x))
    }
}


//MARK:- Forward Application

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}

func apply<A, B>(_ x: A, to f: (A) -> B) -> B {
    return f(x)
}


//MARK:- Forward Composition

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator >>>: ForwardComposition

func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
    return { x in g(f(x)) }
}

// I've heard this called `composeRight` or it could be a regular function called
// `forwardCompose` instead of an infix:

func forwardCompose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
    return { a in
        g(f(a))
    }
}




