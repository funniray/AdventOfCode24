import Foundation

class Day11: Day {
    let inputFile = "./Inputs/day11.txt"
    var input: Data? = nil

    func run() {
        let data = readInput()

        print(blink(data, 25))
        print(blink(data, 75))
    }

    func blink(_ data: [Int], _ limit: Int) -> Int {
        var res: Int = 0
        for num in data {
            res += process(num, limit, 0)
        }
        return res
    }

    func process(_ num: Int, _ limit: Int, _ i: Int) -> Int {
        if i >= limit {return 1}
        if num == 0 {
            return process(1, limit, i+1)
        } 
        let digits = countDigits(num)
        if digits % 2 == 0 {
            let split = splitDigits(num, digits)
            return process(split.0, limit, i+1) + process(split.1, limit, i+1)
        } else {
            return process(num*2024, limit, i+1)
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

    func readInput() -> [Int] {
        return self.input!.read2DArray()[0]
    }

}