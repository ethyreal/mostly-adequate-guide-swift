//: [Previous](@previous)

import Foundation

/*:
 Functional Husbandry

 Here's a more friendly _compose_ for you my dear readers:
 */

func compose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
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


//: [Next](@next)
