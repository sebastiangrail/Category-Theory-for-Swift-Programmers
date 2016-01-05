
/*:
[Previous chapter](Categories%20Great%20and%20Small)

# Kleisli Categories

[Read this chapter online](http://bartoszmilewski.com/2014/12/23/kleisli-categories/)

*/

//: Imperative Logging

var globalLogger = ""

func impureLogNegate (b: Bool) -> Bool {
    globalLogger += "Not so! "
    return !b
}

//: Aggregating log in function

func pureLogNegate (b: Bool, logger: String) -> (Bool, String) {
    return (!b, logger + "Not so! ")
}

//: `negate` returning log, aggregation happens outside the function

func negate (b: Bool) -> (Bool, String) {
    return (!b, "Not so! ")
}


//: `toUpper` and `toWords`

func toUpper (s: String) -> String {
    return s.uppercaseString
}

import Foundation
func toWords (s: String) -> [String] {
    return s.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}


//: `Writer` type

struct Writer <T> {
    let value: T
    let string: String
}

//: `toUpper` and `toWords` returning a writer

func toUpperW (s: String) -> Writer<String> {
    return Writer(value: toUpper(s), string: "toUpper ")
}

func toWordsW (s: String) -> Writer<[String]> {
    return Writer(value: toWords(s), string: "toWords ")
}

//: manually combining `toUpper` and `toWords`

func processM (s: String) -> Writer<[String]> {
    let upper = toUpperW(s)
    let words = toWordsW(upper.value)
    return Writer(value: words.value, string: upper.string + words.string)
}


//: embellished `isEven`
func isEven (n: Int) -> (Bool, String) {
    return  (n % 2 == 0, "isEven ")
}

//: Manually composed `isOdd`
func isOddManually (n: Int) -> (Bool, String) {
    let (result1, log1) = isEven(n)
    let (result2, log2) = negate(result1)
    return (result2, log1 + log2)
}

func compose <A, B, C> (f: A -> Writer<B>, g: B -> Writer<C>) -> A -> Writer<C> {
    return { a in
        let r1 = f(a)
        let r2 = g(r1.value)
        return Writer(value: r2.value, string: r1.string + r2.string)
    }
}

//: We can no create a `process` function using `compose`:

let process = compose(toUpperW, g: toWordsW)


//: The `identity` function for `Writer` is just calling the initializer with an empty log string

func identity <A> (value: A) -> Writer<A> {
    return Writer(value: value, string: "")
}


/*:
 We could write a compose function for any pair (T, Monoid) using the `Monoid` from the [challenges from chapter 3](Solutions%203):

    func compose <A, B, C, M: Monoid> (f: A -> (B, M), B -> (C, M)) -> A -> (C, M) {
        let (result1, log1) = f(a)
        let (result2, log2) = g(result1)
        return (result2, log1.append(log2))
    }

With `identity` defined as

    func identity <A, M: Monoid> (a: A) -> (A, M) {
        return (a, M.empty)
    }

*/


