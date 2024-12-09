import Foundation

class Day9: Day {
    let inputFile = "./Inputs/day9.txt"
    var input: Data? = nil

    func run() {
        let data = readInput()

        var p1Data = data.0
        var p2Data = data.0
        var nextIndex = 0
        for i in (0..<p1Data.count).reversed() {
            nextIndex = getFreeIndex(nextIndex, p1Data, max: i)
            if nextIndex == -1 || nextIndex >= i {break}
            p1Data.swapAt(i,nextIndex)
        }
        var nextIndexP2: [Int] = Array(repeating: 0, count: 9)
        for block in data.1.reversed() {
            let next = nextIndexP2[block.length-1]
            if  next == -1 || next >= block.startIndex {continue}
            let i = getFreeIndexWithSize(nextIndexP2[block.length-1], p2Data, max: block.startIndex, size: block.length)
            nextIndexP2[block.length-1] = i
            if i == -1 {continue}
            for j in 0..<block.length {
                p2Data.swapAt(i+j,block.startIndex+j)
            }
        }

        // print(p2Data.map{$0 == nil ? "." : String($0!)}.joined(separator: ""))
        print("Part 1 answer \(genChecksum(p1Data))")
        print("Part 2 answer \(genChecksum(p2Data))")
    }

    func genChecksum(_ data: [Int?]) -> Int {
        var res = 0
        for (i,v) in data.enumerated() {
            res += i*(v == nil ? 0 : v!)
        }
        return res
    }

    func getFreeIndex(_ startIndex: Int, _ data: [Int?], max: Int) -> Int {
        for i in startIndex..<max {
            if data[i] == nil {return i}
        }
        return -1
    }

    func getFreeIndexWithSize(_ startIndex: Int, _ data: [Int?], max: Int, size: Int) -> Int {
        for i in startIndex..<max {
            if data[i] != nil {continue}
            var matches = true
            for j in i..<i+size {
                if data[j] != nil {
                    matches = false
                    break
                }
            }
            if matches {return i}
        }
        return -1
    }

    func readInput() -> ([Int?],[Block]) {
        let data = self.input!.read1DInt()
        var out: [Int?] = []
        var blocks: [Block] = []
        out.reserveCapacity(10240)
        blocks.reserveCapacity(data.count/2)
        for (i,num) in data.enumerated() {
            if i % 2 == 0 {
                blocks.append(Block(int: i/2, length: num, startIndex: out.count))
                for _ in 0..<num {
                    out.append(i/2)
                }
            } else {
                for _ in 0..<num {
                    out.append(nil)
                }
            }
        }
        return (out,blocks)
    }
}

struct Block {
    let int: Int
    let length: Int
    let startIndex: Int
}
