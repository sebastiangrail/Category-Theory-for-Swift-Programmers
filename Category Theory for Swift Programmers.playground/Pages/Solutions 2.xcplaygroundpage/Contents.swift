//: [Back to Types and Functions](Types%20and%20Functions)

/*:
1. Define a higher-order function (or a function object) memoize in your favorite language. This function takes a pure function f as an argument and returns a function that behaves almost exactly like f, except that it only calls the original function once for every argument, stores the result internally, and subsequently returns this stored result every time it’s called with the same argument. You can tell the memoized function from the original by watching its performance. For instance, try to memoize a function that takes a long time to evaluate. You’ll have to wait for the result the first time you call it, but on subsequent calls, with the same argument, you should get the result immediately.
*/

class Shared <T> {
    var value: T
    
    init (value: T) {
        self.value = value
    }
}


func memoize <T: Hashable, U> (f: T -> U) -> T -> U {
    let results = Shared(value: [T: U]())
    return { t in
        if let result = results.value[t] {
            return result
        } else {
            let result = f(t)
            results.value[t] = result
            return result
        }
    }
}

func fib (n: Int) -> Int {
    switch n {
    case 0, 1:
        return 1
    default:
        return fib(n-2) + fib(n-1)
    }
}



import Foundation

func timed (f: () -> Void) -> NSTimeInterval {
    let start = NSDate()
    f()
    return -start.timeIntervalSinceNow
}

func slowInc (n: Int) -> Int {
    sleep(1)
    return n+1
}

let memoizedSlowInc = memoize(slowInc)
timed {
    for _ in 0..<2 {
        print(slowInc(0))
    }
}
timed {
    for _ in 0..<1000 {
        print(memoizedSlowInc(0))
    }
}


/*: 2. Try to memoize a function from your standard library that you normally use to produce random numbers. Does it work?

`Void` does not conform to `Hashable`, we can instead memoize `arc4random_uniform`
*/

//: `Void` is not hashable, so we define a new singleton set. This lets us memoize `random`.
enum SingletonSet { case Value }
extension SingletonSet: Equatable {
}

extension SingletonSet: Hashable {
    var hashValue: Int { return 0 }
}

func random (x: SingletonSet) -> UInt32 {
    return arc4random()
}

random(.Value)
random(.Value)
random(.Value)
let memoizedRandom = memoize(random)
memoizedRandom(.Value)
memoizedRandom(.Value)
memoizedRandom(.Value)

//: As expected, memoizing `random` gives us the same number for every call where the non-memoized function gave a different number each time.


/*: 3. Most random number generators can be initialized with a seed. Implement a function that takes a seed, calls the random number generator with that seed, and returns the result. Memoize that function. Does it work?
*/

func randomNumberWithSeed (seed: UInt32) -> Int32 {
    srand(seed)
    return rand()
}

randomNumberWithSeed(123)
randomNumberWithSeed(123)
randomNumberWithSeed(123)
let memoizedRandomWithSeed = memoize(randomNumberWithSeed)
memoizedRandomWithSeed(123)
memoizedRandomWithSeed(123)
memoizedRandomWithSeed(123)

//: Because the resul of `randomNumberWithSeed` depends only on the input, in can be memoized.


/*: 4. Which of these functions are pure? Try to memoize them and observe what happens when you call them multiple times: memoized and not.
*/

//: 1. factorial

func factorial (n: Int) -> Int {
    return (1...n).reduce(1, combine: *)
}

factorial(10)
factorial(10)
factorial(10)
let memoizedFactorial = memoize(factorial)
memoizedFactorial(10)
memoizedFactorial(10)
memoizedFactorial(10)

//: `factorial` is pure


//: 2. can't read from stdin in playground, but obviously not pure.

//: 3. 

func sayHello (s: SingletonSet) -> Bool {
    print("Hello!")
    return true
}
sayHello(.Value)
sayHello(.Value)
sayHello(.Value)
let memoizedF = memoize(sayHello)
memoizedF(.Value)
memoizedF(.Value)
memoizedF(.Value)

//: memoized `sayHello` only prints on the first call, I/O is impure


//: 4.

func statefulAdd (x: Int) -> Int {
    struct Container {
        static var y = 0
    }
    Container.y += x
    return Container.y
}
statefulAdd(23)
statefulAdd(23)
statefulAdd(23)
let memoizedG = memoize(statefulAdd)
memoizedG(23)
memoizedG(23)
memoizedG(23)
memoizedG(42)
memoizedG(42)
memoizedG(42)


/*:
5. How many different functions are there from Bool to Bool? Can you implement them all?

two possible inputs: True or False
two possible outpus: True or False

          | True | False
    --------------------
    True  |  id  |   !
    --------------------
    False |   !  |  id

*/

enum Boolean { case True, False }

func id (b: Boolean) -> Boolean { return b }

func not (b: Boolean) -> Boolean {
    switch b {
    case .True: return .False
    case .False: return .True
    }
}


