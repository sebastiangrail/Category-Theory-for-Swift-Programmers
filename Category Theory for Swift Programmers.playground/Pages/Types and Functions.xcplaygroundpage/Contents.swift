
/*:
[Previous chapter](Category%20-%20The%20Essence%20of%20Composition)

# Types and Functions

[Read this chapter online](http://bartoszmilewski.com/2014/11/24/types-and-functions/)


# ⊥ (bottom) in Swift
 
Swift 3 introduces the `Never` type which is an enum without any cases, so that in can never be constructed.


### A function returning ⊥

First, we need a value like Haskell's `undefined :: a`.
In Swift values need to have concrete types so we can't create a value that can have any type. Instead we can create a function that can return any type `undefined: () -> T`.
Calling `fatalError` inside the function tells the compiler that this will halt the programm (`fatalError()` returns `Never`, which is the same as ⊥. We can use `undefined()` to satisfy the type checker for any type, but once executed, it will crash at runtime.
*/

func undefined <T> () -> T { fatalError() }


/*: ### The Empty Set
In Swift, an `enum` with no `case`s cannot be constructed. We can thus define the empty set as such:

*/
enum EmptySet { }

/*: ### `absurd` in Swift
Note that this function can never be called as there is no value in the empty set that we could pass in as an argument. Instead of `EmptySet` we could also use `Never`.
*/

func absurd <T> (_: EmptySet) -> T { return undefined() }


/*" ### The singleton set
In Swift the singleton set is `Void` and its only value is `()`.
A pure function from `Void` to `Int` can look like this:
*/

func f44 (_: Void) -> Int { return 44 }

//: Of course in Swift we can omit the argument if it is `Void`:

func f23 () -> Int { return 23 }


//: ### A pure function returning `Void`:
func unit <T> (_: T) -> Void { }

//: `Void` is implicitly returned, instead we could also explicitly return the value `()`
func unit2 <T> (_: T) -> Void { return () }


/*: ### `Bool` in Swift
We can reimplement a boolean type in Swift with an enum with two values, `True` and `False`:
*/

enum Boolean {
    case True, False
}

//: Have a look at the [solutions to the challanges for this chapter](Solutions%202) or go to [the next chapter](Categories%20Great%20and%20Small)
