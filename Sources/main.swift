// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

exit(main() ? 0 : 1)

func main() -> Bool {
    var input = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : nil

    if (input == nil) {
        print("What day would you like to run?")
        input = readLine()
    }

    if (input == nil) {
        return false
    }

    let day = Int(input!)

    if (day == nil) {
        print("Invalid input \(input!). Must be a number")
        return false
    }

    var implementation: Day?
    switch (day!) {
        case 1: 
            implementation = Day1()
            break
        case 2:
            implementation = Day2()
            break
        case 3:
            implementation = Day3()
            break
        case 4:
            implementation = Day4()
            break
        case 5:
            implementation = Day5()
            break
        case 6:
            implementation = Day6()
            break
        case 7:
            implementation = Day7()
            break
        case 8:
            implementation = Day8()
            break
        case 9:
            implementation = Day9()
            break
        case 10:
            implementation = Day10()
            break
        case 11:
            implementation = Day11()
            break
        default: 
            print("Unknown day \(day!)")
            implementation = nil
            return false
    }
    let readStartMs = Date().timeIntervalSince1970 * 1_000
    implementation!.readInput()
    if implementation!.input == nil {return false}
    let startMs = Date().timeIntervalSince1970 * 1_000
    implementation!.run()
    let endMs = Date().timeIntervalSince1970 * 1_000
    print("Read input in \(startMs - readStartMs)ms. Took \(endMs - startMs)ms to run day \(day!)")

    return true
}