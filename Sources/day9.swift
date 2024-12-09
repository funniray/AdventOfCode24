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
            nextIndex = getFreeIndex(nextIndex, p1Data)
            if nextIndex == -1 || nextIndex >= i {break}
            p1Data.swapAt(i,nextIndex)
        }
        for block in data.1.reversed() {
            let i = getFreeIndexWithSize(p2Data, size: block.length)
            if i >= block.startIndex || i == -1 {continue}
            for j in 0..<block.length {
                p2Data.swapAt(i+j,block.startIndex+j)
            }
        }
        let p1 = p1Data.compactMap{$0}
        let p2 = p2Data.map{$0 == nil ? 0 : $0}.compactMap{$0}

        // print(p2Data.map{$0 == nil ? "." : String($0!)}.joined(separator: ""))
        print("Part 1 answer \(genChecksum(p1))")
        print("Part 2 answer \(genChecksum(p2))")
    }

    func genChecksum(_ data: [Int]) -> Int {
        var res = 0
        for (i,v) in data.enumerated() {
            res += i*v
        }
        return res
    }

    func getFreeIndex(_ startIndex: Int, _ data: [Int?]) -> Int {
        for i in startIndex..<data.count {
            if data[i] == nil {return i}
        }
        return -1
    }

    func getFreeIndexWithSize(_ data: [Int?], size: Int) -> Int {
        for i in 0..<data.count-size {
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
        for (i,num) in data.enumerated() {
            if i % 2 == 0 {
                blocks.append(Block(int: i/2, length: num, startIndex: out.count))
                out.append(contentsOf: Array(repeating: i/2, count: num))
            } else {
                out.append(contentsOf: Array(repeating: nil, count: num))
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