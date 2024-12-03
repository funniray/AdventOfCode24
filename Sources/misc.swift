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
            let whitespace = newline || val == 32
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