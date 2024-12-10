import Foundation

#if os(Windows)
let fileSeperator = "\r\n"
#else
let fileSeperator = "\n"
#endif

extension String {
    // String.components is really slow on windows for some reason
    // because of this, we use the "slower" string.split on windows
    func fastSplit(separatedBy separator: String) -> [String] {
        #if os(Windows)
        return self.split(separator: separator).map{String($0)}
        #else
        return self.components(separatedBy: separator)
        #endif
    }
}

extension Data {
    func read2DArray() -> [[Int]] {
        var res: [[Int]] = []
        var line: [Int] = []
        var working: Int? = nil
        for val in self {
            let newline = val == 10 || val == 13 // \r or \n
            let whitespace = newline || val == 32 || val == 44 || val == 124 || val == 58 // We include | and , as whitespace
            let number = !whitespace && val >= 48 && val <= 57
            let numberValue = number ? val-48 : nil
            if whitespace && working != nil {
                line.append(working!)
                working = nil
            }
            if newline && line.count > 0 {
                res.append(line)
                line = []
            } else if number {
                if (working == nil) {
                    working = Int(numberValue!)
                } else {
                    working = (working! * 10) + Int(numberValue!)
                }
            }
        }
        if working != nil {
            line.append(working!)
        }
        if line.count > 0 {
            res.append(line)
        }
        return res
    }

    func readOptional2DArray() -> [[Int?]] {
        var res: [[Int?]] = []
        var line: [Int?] = []
        for val in self {
            let newline = val == 10 || val == 13 // \r or \n
            let number = val >= 48 && val <= 57
            let numberValue = number ? val-48 : nil
            if newline {
                if line.count == 0 {continue}
                res.append(line)
                line = []
            } else if !number {
                line.append(nil)
            } else {
                line.append(Int(numberValue!))
            }
        }
        if line.count > 0 {
            res.append(line)
        }
        return res
    }

    func read2DCharArray() -> [[Character]] {
        var res: [[Character]] = []
        var line: [Character] = []
        for val in self {
            let newline = val == 10 || val == 13 // \r or \n
            if newline {
                if line.count < 1 {continue}
                res.append(line)
                line = []
            } else {
                line.append(Character(Unicode.Scalar(val)))
            }
        }
        if line.count > 0 {
            res.append(line)
        }
        return res
    }

    

    func read1DInt() -> [Int] {
        var res: [Int] = []
        for val in self {
            res.append(Int(val-48))
        }
        return res
    }
}

protocol Day {
    var inputFile: String { get }
    var input: Data? { set get }
    func run()
}

extension Day {
    mutating func readInput() {
        let file = FileHandle(forReadingAtPath: self.inputFile)
        if file == nil {
            print("Unable to open input \(self.inputFile).")
            return
        }

        self.input = file!.readDataToEndOfFile()
    }
}