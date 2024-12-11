import Foundation

class Day11: Day {
    let inputFile = "./Inputs/day11.txt"
    var input: Data? = nil

    func run() {
        let data = readInput()

        print(countDigits(2024))
        print(splitDigits(2024,countDigits(2024)))

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
            let dNum = Double(num.key)
            let digits = countDigits(dNum)
            if num.key == 0 {
                appendOrInc(&res, 1, num.value)
            } else if digits.truncatingRemainder(dividingBy: 2) == 0 {
                let split = splitDigits(dNum, digits)
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

    func splitDigits(_ num: Double, _ digits: Double) -> (Int, Int) {
        let power = pow(10.0, digits/2.0)
        let left = Int(floor(num/power))
        let right = Int(num.truncatingRemainder(dividingBy: power))
        return (left,right)
    }

    func countDigits(_ num: Double) -> Double {
        return floor(log10(num))+1
    }

    func readInput() -> [Int: Int] {
        var data: [Int: Int] = [:]
        for num in self.input!.read2DArray()[0] {
            appendOrInc(&data, num, 1)
        }
        return data
    }

}