import Foundation

class Day10: Day {
    let inputFile = "./Inputs/day10.txt"
    var input: Data? = nil

    static let cardinal: [Direction] = [
        .north,
        .south,
        .east,
        .west
    ]

    static let min = Point(0,0)

    func run() {
        let data = getInput()
        let max = Point(data.0.count, data.0[0].count)

        var p1 = 0
        var p2 = 0
        for point in data.1 {
            var points: [Point] = []
            traversePoint(point, 0, data.0, max: max, &points)
            p1 += Set(points).count
            p2 += points.count
        }

        print("Part 1 answer \(p1)")
        print("Part 2 answer \(p2)")
    }

    func traversePoint(_ point: Point, _ current: Int, _ map: [[Int?]], max: Point, _ points: inout [Point]) {
        for dir in Day10.cardinal {
            let newPoint = point + dir.offset
            if !(newPoint >= Day10.min && newPoint < max) {continue}
            let intAt = map[newPoint.y][newPoint.x]
            if intAt != nil && intAt!-1 == current {
                if intAt != 9 {
                    traversePoint(newPoint, intAt!, map, max: max, &points)
                } else {
                    points.append(newPoint)
                }
            }
        }
    }

    func getInput() -> ([[Int?]], [Point]) {
        let data = self.input!.readOptional2DArray()
        var points: [Point] = []

        for (y,row) in data.enumerated() {
            for (x,num) in row.enumerated() {
                if (num == 0) {
                    points.append(Point(x,y))
                }
            }
        }

        return (data,points)
    }



}