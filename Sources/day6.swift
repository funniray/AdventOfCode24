import Foundation

class Day6: Day {
    let inputFile = "./Inputs/day6.txt"
    var input: Data? = nil

    func run() {
        let semaphore = DispatchSemaphore(value: 0)
        let dat = getMap()

        Task {
            await Day6.main(dat: dat)
            semaphore.signal()
        }

        semaphore.wait()
    }

    static func main(dat: (Point,[[Bool]])) async {
        let map = dat.1
        let pos = dat.0
        let max = Point(map[0].count-1, map.count-1)

        let p1 = await Day6.simulate(pos, map, max, true)

        var p2 = 0

        await withTaskGroup(of: Bool.self) { group in
            for testPos in p1.0 {
                let obstical = map[testPos.y][testPos.x]

                if testPos == pos || obstical {continue}

                group.addTask {
                    var newMap = map
                    newMap[testPos.y][testPos.x] = true
                    return await Day6.simulateP2(pos, newMap, max)
                }
            }

            for await res in group {
                if res {
                    p2 += 1
                }
            }
        }
        

        print("Part 1 answer \(p1.0.count); took \(p1.1) iterations")
        print("Part 2 answer \(p2)")
    }

    static func simulateP2(_ startingPoint: Point, _ map: [[Bool]], _ max: Point) async -> Bool {
        var pos = startingPoint
        var direction = Direction.west
        var visited: [UInt8] = Array(repeating: 0, count: (max.y+1)*(max.x+1))
        while inMap(pos: pos, max) {
            let nextPos = direction.offset + pos
            if !inMap(pos: nextPos, max) {break}
            let obstical = map[nextPos.y][nextPos.x]

            if (obstical) {
                direction = direction.clockwise
            } else {
                pos = nextPos
                let index = (max.y*pos.y)+pos.x
                // Visited the same point in the same direction twice.
                if (visited[index] & direction.bit) != 0 {
                    return true
                } else {
                    visited[index] |= direction.bit
                }
            }
        }
        return false
    }

    static func simulate(_ startingPoint: Point, _ map: [[Bool]], _ max: Point, _ useSet: Bool) async -> (Set<Point>, Int) {
        var pos = startingPoint
        var direction = Direction.west
        var visited: Set<Point> = Set([pos])
        var iterations = 0
        while inMap(pos: pos, max) && iterations < 20_000 {
            let nextPos = direction.offset + pos
            if !inMap(pos: nextPos, max) {break}
            let obstical = map[nextPos.y][nextPos.x]

            if (obstical) {
                direction = direction.clockwise
            } else {
                pos = nextPos
                if useSet {visited.insert(pos)}
            }
            iterations += 1
        }
        return (visited, iterations)
    }

    static func inMap(pos: Point, _ max: Point) -> Bool {
        return pos.x >= 0 && pos.x <= max.x && pos.y >= 0 && pos.y <= max.y
    }

    // True is obstical; false is open space
    func getMap() -> (Point,[[Bool]]) {
        let out = self.input!.read2DCharArray()
        var pos: Point? = nil
        for (y,row) in out.enumerated() {
            for (x,char) in row.enumerated() {
                if char == "^" {
                    pos = Point(x,y)
                }
            }
        }

        return (pos!,out.map{$0.map{$0 == "#"}})
    }
}

struct PosWithDirection: Hashable {
    let pos: Point
    let dir: Direction
}

extension Direction {
    var clockwise: Direction {
        switch (self) {
            case .north: return .east
            case .east: return .south
            case .south: return .west
            case .west: return .north
            default: return .north
        }
    }

    var bit: UInt8 {
        switch (self) {
            case .north: return 1 << 0
            case .east: return 1 << 1
            case .south: return 1 << 2
            case .west: return 1 << 3
            default: return 0
        }
    }
}