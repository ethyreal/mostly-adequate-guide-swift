//: [Previous](@previous)

import Foundation

/*:
 Functional Husbandry

 Here's a more friendly _compose_ for you my dear readers:
 */

func compose<A, B, C>(_ g: @escaping (B) -> C, _ f: @escaping (A) -> B) -> (A) -> C {
    return { a in
        g(f(a))
    }
}

/*:
 `f` and `g` are functions and `x` is the value being "piped" through them.

 Composition feels like function husbandry.
 You, breeder of functions, select two with traits you'd like to combine and
 mash them together to spawn a brand new one. Usage is as follows:
 */

let toUpperCase = { (x:String) in x.uppercased() }
let exclaim = { (x:String) in "\(x)!" }
let shout = compose(exclaim, toUpperCase)

shout("send in the clowns") // "SEND IN THE CLOWNS!"

/*:

 The composition of two functions returns a new function.
 This makes perfect sense: composing two units of some type (in this case function)
 should yield a new unit of that very type. You don't plug two legos together and
 get a lincoln log. There is a theory here, some underlying law that we will
 discover in due time.

 In our definition of `compose`, the `g` will run before the `f`, creating a
 right to left flow of data. This is much more readable than nesting a bunch of
 function calls. Without compose, the above would read:
 */

let shout2 = { (x:String) in exclaim(toUpperCase(x)) }

/*:
 Instead of inside to outside, we run right to left, which I suppose is a step
 in the left direction (boo!). Let's look at an example where sequence matters:
*/


func head(_ x:[String]) -> String {
    return x.first ?? ""
}

func reverse(_ x:[String]) -> [String] {
    return x.reversed()
}

let last = compose(head, reverse)

last(["jumpkick", "roundhouse", "uppercut"]) // "uppercut"


/*:
 `reverse` will turn the list around while `head` grabs the initial item.
 This results in an effective, albeit inefficient, `last` function.
 The sequence of functions in the composition should be apparent here.
 We could define a left to right version, however, we mirror the mathematical
 version much more closely as it stands. That's right, composition is straight
 from the math books. In fact, perhaps it's time to look at a property
 that holds for any composition.

 // associativity
 compose(f, compose(g, h)) === compose(compose(f, g), h)

 Composition is associative, meaning it doesn't matter how you group two of them.
 So, should we choose to uppercase the string, we can write:
 */

compose(toUpperCase, compose(head, reverse))
// or
compose(compose(toUpperCase, head), reverse)

/*:
 Since it doesn't matter how we group our calls to compose, the result will be the same.
 That allows us to write an infix verson of our method compose method:

 EDIT: instead of variadic compose, create an infix function to backwoards compose
*/

precedencegroup BackwardsComposition {
    associativity: left
}

infix operator <<<: BackwardsComposition

func <<< <A, B, C>(_ g: @escaping (B) -> C, _ f: @escaping (A) -> B) -> (A) -> C {
    return compose(g, f)
}

// previously we'd have to write two composes, but since it's associative,
// we can give compose as many fn's as we like and let it decide how to group them.

let arg = ["jumpkick", "roundhouse", "uppercut"]
let lastUpper = toUpperCase <<< head <<< reverse
let loudLastUpper = exclaim <<< toUpperCase <<< head <<< reverse

lastUpper(arg) // 'UPPERCUT'
loudLastUpper(arg) // 'UPPERCUT!”

//: [Next](@next)
