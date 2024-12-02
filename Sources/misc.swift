import Foundation

extension String {   
    func trim() -> String {
    return self.trimmingCharacters(in: .whitespaces)
   }
}

protocol Day {
    var inputFile: String { get }
    var input: String { set get }
    func run()
}

extension Day {
    mutating func readInput() {
        do {
            let content = try String(contentsOfFile: self.inputFile, encoding: .utf8)
            self.input = content
        } catch (let error) {
            print("Unable to open input \(self.inputFile).\n\(error)")
            exit(0)
        }
    }
}