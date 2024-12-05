import Foundation

class Day4: Day {
    let inputFile = "./Inputs/day4.txt"
    var input: Data? = nil

    var maxX = 0
    var maxY = 0

    let diagonalDirs: [Direction] = [
        .northwest,
        .southwest,
        .northeast,
        .southeast
    ]

    func run() {
        let text = self.input!.read2DCharArray()
        let ordered = text.map{$0.map{self.mapCharacterToOrder($0)}}
        maxY = ordered.count-1
        maxX = ordered[0].count-1
        
        var p1 = 0
        var p2 = 0

        for y in 0...maxY {
            for x in 0...maxX {
                if ordered[y][x] == 0 {
                    p1 += checkXmas(ordered, Point(x,y))
                } else if ordered[y][x] == 2 && checkCross(ordered, Point(x,y)) {
                    p2 += 1
                }
            }
        }

        print("Part 1 answer \(p1)")
        print("Part 2 answer \(p2)")
    }

    func checkCross(_ data: [[Int]], _ point: Point) -> Bool {
        if (point.x < 1 || point.y < 1 || point.x >= maxX || point.y >= maxY) {return false}
        var matches = 0
        for dir in diagonalDirs {
            if self.isLineValid(data, dir, (getOffsetForDirection(dir) * -2) + point) {
                matches += 1
            }
        }
        return matches == 2
    }

    func checkXmas(_ data: [[Int]], _ point: Point) -> Int {
        var occurances = 0
        for dir in Direction.allCases {
            if self.isLineValid(data, dir, point) {
                occurances += 1
            }
        }
        return occurances
    }

    func mapCharacterToOrder(_ char: Character) -> Int {
        switch (char) {
            case "X":
                return 0
            case "M":
                return 1
            case "A":
                return 2
            case "S":
                return 3
            default:
                return -1
        }
    }

    func getOffsetForDirection(_ dir: Direction) -> Point {
        switch dir {
            case .north:
                return Point(1,0)
            case .south:
                return Point(-1,0)
            case .east:
                return Point(0,1)
            case .west:
                return Point(0,-1)
            case .northwest:
                return Point(1,-1)
            case .northeast:
                return Point(1,1)
            case .southwest:
                return Point(-1,-1)
            case .southeast:
                return Point(-1,1)
        }
    }

    func getOrderInDirection(_ data: [[Int]], _ dir: Direction, _ point: Point) -> (Int, Point) {
        let res = point + self.getOffsetForDirection(dir)
        if res.x < 0 || res.y < 0 || res.x > maxX || res.y > maxY {
            return (-1, res)
        }

        return (data[res.y][res.x], res)
    }

    func isLineValid(_ data: [[Int]], _ dir: Direction, _ point: Point) -> Bool {
        var currentPoint = point
        for val in 1...3 {
            let result = self.getOrderInDirection(data, dir, currentPoint)
            if result.0 != val {
                return false
            } else {
                currentPoint = result.1
            }
        }
        return true
    }
    
}

struct Point {
    var x: Int = 0, y: Int = 0

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

extension Point {
    static func + (left: Point, right: Point) -> Point {
        return Point(left.x + right.x, left.y + right.y)
    }

    static func * (left: Point, right: Int) -> Point {
        return Point(left.x * right, left.y * right)
    }
}

enum Direction {
    case north
    case south
    case east
    case west

    case northwest
    case southwest
    case northeast
    case southeast
}

extension Direction: CaseIterable {}