import Foundation

class Day1: Day {
    let inputFile = "./Inputs/day1.txt"
    var input: Data? = nil

    func run() {
        let sets = getSets()

        var totalPart1 = 0
        var totalPart2 = 0
        var secondIndex = 0

        for (i,value1) in sets[0].enumerated() {
            // Part 1
            totalPart1+=abs(value1 - sets[1][i])
            // Part 2
            var occurances = 0
            for j in (secondIndex...sets[1].count-1) {
                let value2 = sets[1][j]
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

    func getSets() -> [[Int]] {
        // Transform text from 1   2\n1   2 to [[1,2],[1,2]]
        let nums = self.input!.read2DArray()
        // Transforms text from [[1,2],[1,2]] to [[1,1],[2,2]]
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