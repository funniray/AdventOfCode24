import Foundation

class Day3: Day {
    let inputFile = "./Inputs/day3.txt"
    var input: Data? = nil

    func run() {
        let matches = getMatches()
        
        print("Part 1 answer \(reduce(matches[0]))")
        print("Part 2 answer \(reduce(matches[1]))")
    }

    func reduce(_ input: [[Int]]) -> Int {
        let products = input.map{$0[0]*$0[1]}
        return products.reduce(0, {$0+$1})
    }

    func getMatches() -> [[[Int]]] {
        let inputStr = String(decoding: self.input!, as: UTF8.self)
        let capturePattern = #"don't\(\)|do\(\)|mul\((\d+),(\d+)\)"#
        let captureRegex = try! NSRegularExpression(
            pattern: capturePattern,
            options: []
        )

        let nameRange = NSRange(
            inputStr.startIndex..<inputStr.endIndex,
            in: inputStr
        )

        let matches: [NSTextCheckingResult] = captureRegex.matches(in: inputStr, options: [], range: nameRange)

        var output: [[Int]] = []
        var outputGated: [[Int]] = []
        var enabled = true
        for match in matches {
            var numbers: [Int] = []
            for rangeIndex in 0..<match.numberOfRanges {
                let matchRange = match.range(at: rangeIndex)
                if let substringRange = Range(matchRange, in: inputStr) {
                    let capture = String(inputStr[substringRange])
                    if (rangeIndex == 0) {
                        if (capture == "do()") {
                            enabled = true
                            continue
                        } else if (capture == "don't()") {
                            enabled = false
                            continue
                        }
                    } else {
                        numbers.append(Int(capture)!)
                    }
                }
            }
            if (numbers.count == 0) {continue}
            output.append(numbers)
            if (enabled) {
                outputGated.append(numbers)
            }
        }
        return [output,outputGated]
    }
}