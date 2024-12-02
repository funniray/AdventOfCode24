import Foundation

class Day1: Day {
    let inputFile = "./Inputs/day1.txt"
    var input = ""

    func run() {
        let sets = getSets()
        if (sets == nil) {return}
        var totalPart1 = 0
        var totalPart2 = 0
        var secondIndex = 0
        for (i,value1) in sets![0].enumerated() {
            // Part 1
            totalPart1+=abs(value1 - sets![1][i])
            // Part 2
            var occurances = 0
            for j in (secondIndex...sets![1].count-1) {
                let value2 = sets![1][j]
                if (value1 > value2) {continue}
                if (value1 == value2) {
                    secondIndex = j
                    occurances += 1
                } else {
                    break
                }
            }
            totalPart2+=value1*occurances
        }
        print("Part 1 answer \(totalPart1)")
        print("Part 2 answer \(totalPart2)")
    }

    func getSets() -> [[Int]]? {
        let nums = self.input.split(whereSeparator: \.isNewline).map{$0.split(separator: "   ").map{Int($0)!}}
        var sets: [[Int]] = [[],[]]
        for numSet in nums {
            sets[0].append(numSet[0])
            sets[1].append(numSet[1])
        }
        sets[0].sort()
        sets[1].sort()
        return sets
    }
}