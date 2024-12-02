class Day2: Day {
    let inputFile = "./Inputs/day2.txt"
    var input: String? = nil

    func run() {
        let sets = getSets()!
        var safeSets = 0
        var potentiallySafe = 0
        for set in sets {
            // Part 1
            if (isSafe(set)) {
                safeSets += 1
                // Part 2
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
            // Figure out if it's ascending or decending
            if (dir == 0) {
                if (next > cur) {
                    dir = 1
                } else {
                    dir = -1
                }
            }

            // Ensure the difference is at least one
            if (next == cur) {return false}
            // Ensure the difference is at most three
            if (abs(next - cur) > 3) {return false}
            // Ensure that the values keep ascending/descending 
            if ((dir == -1 && next > cur) || (dir == 1 && next < cur)) {
                return false
            }
        }
        return true
    }

    func getSets() -> [[Int]]? {
        // Converts the input from 1 2 3 4 5\n5 4 3 2 1 to [[1,2,3,4,5],[5,4,3,2,1]]
        let nums = self.input!.components(separatedBy: fileSeperator).map{$0.components(separatedBy: " ").map{Int($0)!}}
        return nums
    }
}