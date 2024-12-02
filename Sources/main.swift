// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

var input = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : nil

if (input == nil) {
    print("What day would you like to run?")
    input = readLine()
}

if (input == nil) {
    exit(0)
}

let day = Int(input!)

if (day == nil) {
    print("Invalid input \(input!). Must be a number")
    exit(0)
}

var implementation: Day?
switch (day!) {
    case 1: 
        implementation = Day1()
        break
    case 2:
        implementation = Day2()
        break
    default: 
        print("Unknown day \(day!)")
        implementation = nil
        exit(0)
        break
}
let readStartMs = Date().timeIntervalSince1970 * 1_000
implementation!.readInput()
let startMs = Date().timeIntervalSince1970 * 1_000
implementation!.run()
let endMs = Date().timeIntervalSince1970 * 1_000
print("Read input in \(startMs - readStartMs)ms. Took \(endMs - startMs)ms to run day \(day!)")