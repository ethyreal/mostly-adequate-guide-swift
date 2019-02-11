//: [Previous](@previous)

import Foundation

/*:
 Functional Husbandry

 Here's _compose_ :
*/

precedencegroup BackwardsComposition {
    associativity: left
}

infix operator <<<: BackwardsComposition

func <<< <A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}


/*:
 ... Don't be scared! This is the level-9000-super-Saiyan-form of _compose_. For the sake of reasoning, let's drop the infix implementation and consider a simpler form that can compose two functions together. Once you get your head around that, you can push the abstraction further and consider it simply works for any number of functions (we could even prove that)!

 Here's a more friendly _compose_ for you my dear readers:
 */

func compose<A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { a in
        f(g(a))
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

// previously we'd have to write two composes, but since it's associative,
// we can give compose as many fn's as we like and let it decide how to group them.

let arg = ["jumpkick", "roundhouse", "uppercut"]
let lastUpper = toUpperCase <<< head <<< reverse
let loudLastUpper = exclaim <<< toUpperCase <<< head <<< reverse

lastUpper(arg) // 'UPPERCUT'
loudLastUpper(arg) // 'UPPERCUT!

/*:
 Applying the associative property gives us this flexibility and
 peace of mind that the result will be equivalent.

 One pleasant benefit of associativity is that any group of functions can be
 extracted and bundled together in their very own composition.
 Let's play with refactoring our previous example:
 */

let loudLastUpper2 = exclaim <<< toUpperCase <<< head <<< reverse

// -- or ---------------------------------------------------------------

let last2 = head <<< reverse
let loudLastUpper3 = exclaim <<< toUpperCase <<< last

// -- or ---------------------------------------------------------------

let last3 = head <<< reverse
let angry = exclaim <<< toUpperCase
let loudLastUpper4 = angry <<< last

loudLastUpper(arg) // 'UPPERCUT!
loudLastUpper2(arg) // 'UPPERCUT!
loudLastUpper3(arg) // 'UPPERCUT!
loudLastUpper4(arg) // 'UPPERCUT!

/*:
 There's no right or wrong answers - we're just plugging our legos together in
 whatever way we please. Usually it's best to group things in a reusable way like
 `last` and `angry`. If familiar with Fowler's "[Refactoring][refactoring-book]",
 one might recognize this process as "[extract function][extract-function-refactor]"
 ...except without all the object state to worry about.
 */


func compose3(_ g: @escaping (String) -> String, _ f: @escaping (String) -> String) -> (String) -> String {
    return { x in
        g(f(x))
    }
}


//: [Next](@next)


