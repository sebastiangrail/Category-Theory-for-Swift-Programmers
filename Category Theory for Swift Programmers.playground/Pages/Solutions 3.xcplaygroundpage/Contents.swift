//: [Back to Categories Great and Small](Categories%20Great%20and%20Small)

//: 3. Considering that Bool is a set of two values True and False, show that it forms two (set-theoretical) monoids with respect to, respectively, operator && (AND) and || (OR).

protocol Monoid {
    static var empty: Self { get }
    
    func append (_ other: Self) -> Self
}

struct And: Monoid {
    let value: Bool
    
    static var empty: And { return And(value: true) }
    
    func append (_ other: And) -> And {
        return And(value: self.value && other.value)
    }
}


struct Or: Monoid {
    let value: Bool
    
    static var empty: Or { return Or(value: false) }
    
    func append (_ other: Or) -> Or {
        return Or(value: self.value || other.value)
    }
}

let andTrue = And(value: true)
let andFalse = And(value: false)

let orTrue = Or(value: true)
let orFalse = Or(value: false)


And.empty.append(andTrue).value == andTrue.append(And.empty).value
And.empty.append(andFalse).value == andFalse.append(And.empty).value

Or.empty.append(orTrue).value == orTrue.append(Or.empty).value
Or.empty.append(orFalse).value == orFalse.append(Or.empty).value

andTrue.append(andTrue).append(andTrue).value == andTrue.append(andTrue.append(andTrue)).value
//: can be equally tested for other values of the `And` monoid

orFalse.append(orTrue).append(orFalse).value == orFalse.append(orTrue.append(orFalse)).value
//: can be equally tested for other values of the `Or` monoid


//: 5. Represent addition modulo 3 as a monoid category.
struct SumMod3: Monoid {
    let value: Int
    
    static var empty: SumMod3 { return SumMod3(0) }
    
    func append (_ other: SumMod3) -> SumMod3 {
        return SumMod3(self.value + other.value)
    }
    
    init (_ value: Int) {
        self.value = value % 3
    }
}

SumMod3.empty.append(SumMod3(2)).value == SumMod3(2).append(SumMod3.empty).value
SumMod3(2).append(SumMod3(1)).append(SumMod3(2)).value == SumMod3(2).append(SumMod3(1).append(SumMod3(2))).value
