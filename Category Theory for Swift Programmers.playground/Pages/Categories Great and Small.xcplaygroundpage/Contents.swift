
/*:
[Back](Types%20and%20Functions)

# Categories Great and Small

[Read this chapter online](http://bartoszmilewski.com/2014/12/05/categories-great-and-small/)

*/

//: Monoid protocol

protocol Monoid {
    static var empty: Self { get }
    
    func append (other: Self) -> Self
}

//: Like in Haskell, it is impossible to express the monoidal properties of `mempty` (neutral element) and `mappend` (associativity)


//: Make `String` a monoid:

extension String: Monoid {
    static var empty : String { return "" }
    
    func append (other: String) -> String {
        return self + other
    }
}

