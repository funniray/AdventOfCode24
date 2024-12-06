import Foundation

class Day6: Day {
    let inputFile = "./Inputs/day6.txt"
    var input: Data? = nil
    var maxX = 0
    var maxY = 0

    func run() {
        let dat = getMap()
        let map = dat.1
        var pos = dat.0
        maxY = map.count-1
        maxX = map[0].count-1

        let p1 = simulate(pos, map)

        var p2 = 0
        for y in 0...maxY {
            for x in 0...maxX {
                let testPos = Point(x,y)
                let obstical = map[testPos.y][testPos.x]

                if testPos == pos || obstical {continue}

                var newMap = map
                newMap[testPos.y][testPos.x] = true
                if simulate(pos, newMap).1 >= 20_000 {
                    p2 += 1
                }
            }
        }
        

        print("Part 1 answer \(p1.0); took \(p1.1) iterations")
        print("Part 2 answer \(p2)")
    }

    func simulate(_ startingPoint: Point, _ map: [[Bool]]) -> (Int, Int) {
        var pos = startingPoint
        var direction = Direction.west
        var visited: Set<Point> = Set([pos])
        var iterations = 0
        while inMap(pos: pos) && iterations < 20_000 {
            let nextPos = direction.offset + pos
            if !inMap(pos: nextPos) {break}
            let obstical = map[nextPos.y][nextPos.x]

            if (obstical) {
                direction = direction.clockwise
            } else {
                pos = nextPos
                visited.insert(pos)
            }
            iterations += 1
        }
        return (visited.count, iterations)
    }

    func inMap(pos: Point) -> Bool {
        return pos.x >= 0 && pos.x <= maxX && pos.y >= 0 && pos.y <= maxY
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
}