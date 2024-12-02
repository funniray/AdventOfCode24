import Foundation

#if os(Windows)
let fileSeperator = "\r\n"
#else
let fileSeperator = "\n"
#endif

extension String {
    #if os(Windows)
    func fastSplit(separatedBy: String) -> [String] {
        return self.split(separator: separatedBy).map{String($0)}
    }
    #else
    func fastSplit<T>(separatedBy separator: T) -> [String] where T : StringProtocol {
        return self.components(separatedBy: separator)
    }
    #endif
}

protocol Day {
    var inputFile: String { get }
    var input: String? { set get }
    func run()
}

extension Day {
    mutating func readInput() {
        do {
            let content = try String(contentsOfFile: self.inputFile, encoding: .utf8)
            self.input = content
        } catch (let error) {
            print("Unable to open input \(self.inputFile).\n\(error)")
        }
    }
}