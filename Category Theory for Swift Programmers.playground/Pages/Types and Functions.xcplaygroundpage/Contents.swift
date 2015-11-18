
/*:
[Back](Category%20-%20The%20Essence%20of%20Composition)

# Types and Functions

[Read this chapter online](http://bartoszmilewski.com/2014/11/24/types-and-functions/)


# ⊥ (bottom) in Swift


### A function returning ⊥

First, we need a value like Haskell's `undefined :: a`.
In Swift values need to have concrete types so we can't create a value that can have any type. Instead we can create a function that can return any type `undefined: () -> T`.
We need to mark the function as `@noreturn` to indicate that like `⊥`, it corresponds to a non-terminating computation.
*/

@noreturn func undefined <T> () -> T { }

//: Now we can implement a function `f: T -> U` that explicitly returns `⊥`:

func f <T,U> (x: T) -> U {
    return undefined()
}

//: The Swift compiler corretly warns us that the return statement will never be executed and when we actually try to call `f`, the program crashes at runtime.


/*: ### The Empty Set
In Swift, an `enum` with no `case`s cannot be constructed. We can thus define the empty set as such:

*/
enum EmptySet { }

/*: ### `absurd` in Swift
Note that this function can never be called as there is no value in the empty set that we could pass in as an argument
*/

@noreturn func absurd <T> (_: EmptySet) -> T {}


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

