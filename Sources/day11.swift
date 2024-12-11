import Foundation

class Day11: Day {
    let inputFile = "./Inputs/day11.txt"
    var input: Data? = nil

    func run() {
        let data = readInput()

        var p1 = data
        for _ in 0..<25 {
            p1 = blink(p1)
        }
        var p2 = p1
        for i in 0..<50 {
            p2 = blink(p2)
        }
        print(p1.reduce(0,{$1.value + $0}))
        print(p2.reduce(0,{$1.value + $0}))
    }

    func blink(_ data: [Int: Int]) -> [Int: Int] {
        var res: [Int: Int] = [:]
        for num in data {
            let digits = countDigits(num.key)
            if num.key == 0 {
                appendOrInc(&res, 1, num.value)
            } else if digits % 2 == 0 {
                let split = splitDigits(num.key, digits)
                appendOrInc(&res, split.0, num.value)
                appendOrInc(&res, split.1, num.value)
            } else {
                appendOrInc(&res, num.key*2024, num.value)
            }
        }
        return res
    }

    func appendOrInc(_ data: inout [Int: Int], _ index: Int, _ count: Int)  {
        if data[index] != nil {
            data[index]! += count
        } else {
            data[index] = count
        }
    }

    func splitDigits(_ num: Int, _ digits: Int) -> (Int, Int) {
        if digits % 2 == 1 {print("Got odd number input \(num)")}
        let power = pow(10.0, Double(digits)/2.0)
        let left = Int(floor(Double(num)/power))
        let right = num - Int(Double(left)*power)
        return (left,right)
    }

    func countDigits(_ num: Int) -> Int {
        if num >= 1_000_000_000_000_000 {print("Number too large \(num)")}
        if num >= 100_000_000_000_000 {return 15}
        if num >= 10_000_000_000_000 {return 14}
        if num >= 1_000_000_000_000 {return 13}
        if num >= 100_000_000_000 {return 12}
        if num >= 10_000_000_000 {return 11}
        if num >= 1_000_000_000 {return 10}
        if num >= 100_000_000 {return 9}
        if num >= 10_000_000 {return 8}
        if num >= 1_000_000 {return 7}
        if num >= 100_000 {return 6}
        if num >= 10_000 {return 5}
        if num >= 1_000 {return 4}
        if num >= 100 {return 3}
        if num >= 10 {return 2}
        return 1
    }

    func readInput() -> [Int: Int] {
        var data: [Int: Int] = [:]
        for num in self.input!.read2DArray()[0] {
            appendOrInc(&data, num, 1)
        }
        return data
    }

}