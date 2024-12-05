import Foundation

class Day5: Day {
    let inputFile = "./Inputs/day5.txt"
    let inputFile2 = "./Inputs/day5.2.txt"
    var input: Data? = nil

    func run() {
        let all = getRules()
        let rules = all.0
        let inputs = getInputs()

        var p1 = 0
        var p2 = 0
        for input in inputs {
            var valid = true
            for i in 1..<input.count {
                if !isValid(i, input, rules[input[i]] ?? []) {
                    valid = false
                    break
                }
            }
            if valid {
                p1 += input.middle ?? 0
            } else {
                var sorted = input
                var iter = 0
                while iter < 100 && !checkSorted(sorted, rules) {
                    sorted = sort(sorted, rules,all.1)
                    iter += 1
                }
                p2 += sorted.middle ?? 0
            }
        }

        print("Part 1 answer \(p1)")
        print("Part 2 answer \(p2)")
    }

    func checkSorted(_ input: [Int], _ rules: [Int: [Int]]) -> Bool {
        for i in 1..<input.count {
            if !isValid(i, input, rules[input[i]] ?? []) {
                return false
            }
        }
        return true
    }

    func sort(_ data: [Int], _ rules: [Int: [Int]], _ inverse: [Int: [Int]]) -> [Int] {
        var input = data
        for i in 1..<input.count {
            let rule = rules[input[i]] ?? []
            if !isValid(i, input, rule) {
                if let swapIndex = input.indexOf(element: getNext(Array(input[i...]), rules, inverse)) {
                    input.swapAt(i-1, swapIndex)
                }
            }
        }
        return input
    }

    func getNext(_ data: [Int], _ rules: [Int: [Int]], _ inverse: [Int: [Int]]) -> Int {
        for num in data {
            var temp = data
            temp.removeAll{$0 == num}
            let rule = inverse[num] ?? []
            if temp.allSatisfy({rule.contains($0)}) {
                return num
            }
        }
        print("Hmm... that didn't work...")
        return data[0]
    }

    func isValid(_ index: Int, _ input: [Int], _ rules: [Int]) -> Bool {
        for rule in rules {
            if input[index-1] == rule {
                return true
            }
        }
        return false
    }

    func getRules() -> ([Int: [Int]],[Int: [Int]]) {
        let dat = self.input!.read2DArray()
        var rules: [Int: [Int]] = [:]
        var inverseRules: [Int: [Int]] = [:]
        for row in dat {
            var cur = rules[row[1]]
            if cur == nil {
                cur = []
            }
            cur!.append(row[0])
            rules[row[1]] = cur
        }
        for row in dat {
            var cur = inverseRules[row[0]]
            if cur == nil {
                cur = []
            }
            cur!.append(row[1])
            inverseRules[row[0]] = cur
        }
        return (rules,inverseRules)
    }

    func getInputs() -> [[Int]] {
        if let handle = FileHandle(forReadingAtPath: self.inputFile2) {
            let data = handle.readDataToEndOfFile()
            return data.read2DArray()
        }
        return []
    }
}

extension Array {
    var middle: Element? {
        guard !isEmpty else { return nil }
        return self[count / 2]
    }
}

extension Array where Iterator.Element == Int {
    func indexOf(element: Element) -> Int? {
        for (i,item) in self.enumerated() {
            if item == element {
                return i
            }
        }
        return nil
    }
}