/*:
//: [Back to Kleisli Categories](Kleisli%20Categories)

1. Construct the Kleisli category for partial functions (define composition and identity).

Swift has an optional type in the stdlib: `Optional<Wrapped>` with `T?` as syntactic sugar for `Optional<T>`.
If non-optional values are encountered where an `Optional` is expected it is automatically lifted into the Optional.
E.g. `let x: Int? = 0` and `let x: Int? = .Some(0)` are equvialent.

`safeRoot`:
*/

import Darwin
func safeRoot (x: Double) -> Double? {
    if x >= 0 {
        return sqrt(x)
    } else {
        return nil
    }
}

//: The identity function for values in the Kleisli category for partial functions is just the optional initalizer:

func identity <T> (x: T) -> T? {
    return x
}

//: compose for partial functions

func compose <A, B, C> (f: A -> B?, g: B -> C?) -> A -> C? {
    return { a in
        if let resultF = f(a) {
            return g(resultF)
        } else {
            return nil
        }
    }
}

//: If you have been using Swift for a while, you might notice that this is the same as `flatMap` (We'll see why later)

func compose2 <A, B, C> (f: A -> B?, g: B -> C?) -> A -> C? {
    return { a in
        return f(a).flatMap(g)
    }
}

//: 2. Implement the embellished function safe_reciprocal that returns a valid reciprocal of its argument, if it’s different from zero.

func safeReciprocal (x: Double) -> Double? {
    if x != 0 {
        return 1/x
    } else {
        return nil
    }
}

//: 3. Compose safe_root and safe_reciprocal to implement safe_root_reciprocal that calculates sqrt(1/x) whenever possible.

let safeRootReciprocal = compose(safeReciprocal, g: safeRoot)
