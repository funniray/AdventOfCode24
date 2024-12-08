import Foundation

class Day8: Day {
    let inputFile = "./Inputs/day8.txt"
    var input: Data? = nil

    func run() {
        let data = parseInputs()
        let min = Point(0,0)

        let antinodes = generateAntinodes(data.0, min, data.1)
        print(generateMap(Array(antinodes.1)).map{String($0)}.joined(separator: "\n"))

        print("Part 1 answer \(antinodes.0.count)")
        print("Part 2 answer \(antinodes.1.count)")
    }

    func generateAntinodes(_ nodeList: NodeList, _ min: Point, _ max: Point) -> (Set<Point>,Set<Point>) {
        var antinodesP1: Set<Point> = Set()
        var antinodesP2: Set<Point> = Set()
        for nodes in nodeList {
            for (index, node) in nodes.value.enumerated() {
                antinodesP2.insert(node)
                for (index2, node2) in nodes.value.enumerated() {
                    if index == index2 {continue}
                    let slope = ((node - node2) * -1)
                    var newNode = slope + node2
                    if newNode >= min && newNode <= max {antinodesP1.insert(newNode)}
                    while newNode >= min && newNode <= max {
                        antinodesP2.insert(newNode)
                        newNode = slope + newNode
                    }
                }
            }
        }
        return (antinodesP1,antinodesP2)
    }

    func parseInputs() -> (NodeList,Point) {
        let data = self.input!.read2DCharArray()
        let max = Point(data.count-1, data[0].count-1)
        var out: NodeList = [:]
        for (y,row) in data.enumerated() {
            for (x,char) in row.enumerated() {
                if char == "." || char == "#" {continue}
                if out[char] == nil {
                    out[char] = [Point(x,y)]
                } else {
                    out[char]?.append(Point(x,y))
                }
            }
        }
        return (out,max)
    }

    func generateMap(_ points: [Point]) -> [[Character]] {
        var data = self.input!.read2DCharArray()
        for point in points {
            data[point.y][point.x] = "#"
        }
        return data
    }
}

typealias NodeList = [Character: [Point]]