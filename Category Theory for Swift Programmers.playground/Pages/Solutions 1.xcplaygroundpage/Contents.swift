//: [Back to Category - The Essence of Composition](Category%20-%20The%20Essence%20of%20Composition)

//: ### 2. Implement the composition function in your favorite language. It takes two functions as arguments and returns a function that is their composition.

infix operator • { associativity right }
func • <T,U,V> (lhs: @escaping (U) -> V, rhs: @escaping (T) -> U) -> (T) -> V {
    return { t in
        return lhs(rhs(t))
    }
}


/*: ### 3. Write a program that tries to test that your composition function respects identity.

We want to test if `f • id == f` and `id • f == f` for all functions `f`.
Just like Haskell, Swift doesn't define equality for functions, so the best we can do is to test the functions with as many values as possible. Alternatively we could use a property based testing system like [SwiftCheck](https://github.com/typelift/SwiftCheck)
*/

func id <T> (x: T) -> T { return x }

func testIdentity <T, U: Equatable> (numberOfSamples: Int = 1000, generator: () -> T, f: @escaping (T) -> U) -> Bool {
    return Array(1..<numberOfSamples)
        .map { _ in generator() }
        .reduce(true) { (acc, value) in
        return acc && (id•f)(value) == f(value) && (f•id)(value) == f(value)
    }
}
import Darwin
assert(testIdentity(generator: { Int(arc4random_uniform(UInt32.max-1)) }, f: { $0 + 1 }))

