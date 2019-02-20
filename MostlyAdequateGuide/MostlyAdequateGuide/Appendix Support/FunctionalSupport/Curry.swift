//
//  Curry.swift
//  MostlyAdequateGuide
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import Foundation

// curry :: ((a, b) -> c) -> a -> b -> c

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}
