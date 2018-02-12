/*:

 # A race condition.
 ### "Threads and Locks", Page 12
 [@AndrewSB](github.com/AndrewSB)

 One would expect the `count` at the end of `t1` and `t2`'s lifetime to be `20000`. But, in fact, it is a few hundred lower, and non determinitic, from the graph output below
 ![Results](../Resources/Result.png)
*/

import Foundation

class Runner {
    func run() -> Int {
        var count = 0

        let t1 = Thread {
            for _ in 0..<10000 { count += 1 }
        }
        let t2 = Thread {
            for _ in 0..<10000 { count += 1 }
        }

        [t1, t2].forEach { $0.start() }

        while !t1.isFinished || !t2.isFinished { /*sleep*/ }
        return count
    }
}

let runs = Array(repeating: Runner(), count: 100).map { $0.run() }
