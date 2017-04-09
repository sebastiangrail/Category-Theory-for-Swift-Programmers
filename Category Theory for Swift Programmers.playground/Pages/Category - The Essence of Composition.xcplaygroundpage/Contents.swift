/*:

[Back](Introduction)

# Category: The Essence of Composition

[Read this chapter online](http://bartoszmilewski.com/2014/11/04/category-the-essence-of-composition/)

*/

//: ### The identity arrow for functions

func id <T> (x: T) -> T {
    return x
}

//: When the type can be inferred, the identity function can be written as a closure `{ x in x }` or even just `{$0}`
func intAppliation (_ g: (Int) -> Int, n: Int) -> Int {
    return g(n)
}
intAppliation({$0}, n: 1)


//: Have a look at the [solutions to the challanges for this chapter](Solutions%201) or go to [the next chapter](Types%20and%20Functions)
