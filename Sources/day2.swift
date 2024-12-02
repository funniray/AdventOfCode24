import Foundation

class Day2: Day {
    let inputFile = "./Inputs/day2.txt"
    var input = ""

    func run() {
        let sets = getSets()!
        var safeSets = 0
        var potentiallySafe = 0
        for set in sets {
            if (isSafe(set)) {
                safeSets += 1
                potentiallySafe += 1
            } else if (tryMutations(set)) {
                potentiallySafe += 1
            }
        }
        print("Part 1 answer \(safeSets)")
        print("Part 2 answer \(potentiallySafe)")
    }

    func tryMutations(_ baseSet: [Int]) -> Bool {
        for removedIndex in (0...baseSet.count-1) {
            var set = baseSet
            set.remove(at: removedIndex)
            if (isSafe(set)) {
                return true
            }
        }
        return false
    }

    func isSafe(_ set: [Int]) -> Bool {
        var dir = 0
        for i in (0...set.count-2) {
            let cur = set[i]
            let next = set[i+1]
            if (dir == 0) {
                if (next > cur) {
                    dir = 1
                } else {
                    dir = -1
                }
            }

            if (next == cur) {return false}
            if (abs(next - cur) > 3) {return false}
            if ((dir == -1 && next > cur) || (dir == 1 && next < cur)) {
                return false
            }
        }
        return true
    }

    func getSets() -> [[Int]]? {
        let nums = self.input.split(whereSeparator: \.isNewline).map{$0.split(separator: " ").map{Int($0)!}}
        return nums
    }
}