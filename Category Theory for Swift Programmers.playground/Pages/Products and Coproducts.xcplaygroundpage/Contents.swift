

func fst <T,U> (tuple: (T, U)) -> T {
    return tuple.0
}

func snd <T,U> (tuple: (T, U)) -> U {
    return tuple.1
}

protocol Product {
    associatedtype A
    associatedtype B
    
    func p () -> A
    func q () -> B
}

extension Int: Product {
    func p () -> Int {
        return self
    }
    
    func q () -> Bool {
        return true
    }
}

struct Triple {
    let a: Int
    let b: Int
    let c: Bool
}

extension Triple: Product {
    func p () -> Int {
        return a
    }
    
    func q () -> Bool {
        return c
    }
}

struct Pair <A, B> {
    let a: A
    let b: B
}

extension Pair: Product {
    func p () -> A {
        return a
    }
    
    func q () -> B {
        return b
    }
}

func m (_ n: Int) -> Pair<Int, Bool> {
    return Pair(a: n, b: true)
}

func p (_ x: Int) -> Int {
    return m(x).a
}

func q (_ x: Int) -> Bool {
    return m(x).b
}


func morphism <P: Product> (_ x: P) -> Pair<P.A, P.B> {
    return Pair(a: x.p(), b: x.q())
}


func factorizer <A, B, C> (f: @escaping (C) -> A, g: @escaping (C) -> B) -> (C) -> (A,B) {
    return { c in
        (f(c), g(c))
    }
}



enum Contact {
    case Phone(Int)
    case Email(String)
}

let phoneNum = Contact.Phone


enum Either <T,U> {
    case Left(T)
    case Right(U)
}

// factorizer :: (a -> c) -> (b -> c) -> Either a b -> c

func eitherFactorizer <A, B, C> (f: @escaping (A) -> C, g: @escaping (B) -> C) -> (Either<A, B>) -> C {
    return { either in
        switch either {
        case .Left(let a):
            return f(a)
        case .Right(let b):
            return g(b)
        }
    }
}
