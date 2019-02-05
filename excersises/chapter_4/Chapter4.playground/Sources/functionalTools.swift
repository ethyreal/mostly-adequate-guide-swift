import Foundation

//MARK:- Curry

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}

// MARK: Curry Verbose:
//func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
//    return { a in
//        return { b in
//            return f(a, b)
//        }
//    }
//}

