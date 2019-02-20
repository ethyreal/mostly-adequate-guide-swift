//
//  Split.swift
//  MostlyAdequateGuide
//
//  Created by George Webster on 2/20/19.
//  Copyright © 2019 George Webster. All rights reserved.
//

import Foundation

func split(_ seperator:Character, _ value:String) -> [Substring] {
    return value.split(separator: seperator)
}

// splitC :: String -> String -> [String]

let splitC = curry(split)

