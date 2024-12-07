import Foundation

class Day7: Day {
    let inputFile = "./Inputs/day7.txt"
    var input: Data? = nil

    func run() {
        let data = self.input!.read2DArray()

        var p1 = 0
        var p2 = 0

        for row in data {
            let target = row[0]
            let start = row[1]
            if calculate(start, row, 2, target, useConcat: false) {
                p1 += target
                p2 += target
            } else if calculate(start, row, 2, target, useConcat: true) {
                p2 += target
            }
        }

        print("p1 answer \(p1)")
        print("p2 answer \(p2)")
    }

    func calculate(_ start: Int, _ input: [Int], _ index: Int, _ target: Int, useConcat: Bool) -> Bool {
        if index == input.count {
            return start == target
        }
        let next: Int = input[index]
        let nextIndex = index + 1
        return calculate(start + next, input, nextIndex, target, useConcat: useConcat) 
            || calculate(start * next, input, nextIndex, target, useConcat: useConcat) 
            || (useConcat && calculate(Day7.intConcat(a:start, b:next), input, nextIndex, target, useConcat: useConcat))
    }

    static func getMultiplier(_ num: Int) -> Int {
        if num >= 10_000 {return 100_000}
        if num >= 1_000 {return 10_000}
        if num >= 100 {return 1_000}
        if num >= 10 {return 100}
        return 10
    }

    static func intConcat(a: Int, b: Int) -> Int {
        let multiplied = getMultiplier(b)
        let shifted = a * Int(multiplied)
        return shifted + b
    }
}