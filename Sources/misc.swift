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