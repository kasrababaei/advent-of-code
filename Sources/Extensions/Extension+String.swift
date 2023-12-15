extension Character {
    func toInteger() throws -> Int {
        try "\(self)".toInteger()
    }
}

extension Substring {
    func toInteger() throws -> Int {
        try "\(self)".toInteger()
    }
}

extension String {
    func toInteger() throws -> Int {
        guard let value = Int(self) else {
            throw CustomError()
        }
        
        return value
    }
    
    func leftPadded(toLength length: Int = 2, withPad pad: Character = "0") -> Self {
        let length = max(0, length - count)
        
        return repeatElement(pad, count: length) + self
    }
    
    func padded(toLength length: Int = 25, withPad pad: Character = " ") -> Self {
        padding(toLength: length, withPad: "\(pad)", startingAt: 0)
    }
    
    func to2DArray() -> [[Character]] {
        let lines = components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        guard lines.count == lines.first?.count ?? 0 else {
            fatalError("The number of rows and and columns must be equal.")
        }
        
        return lines.map { line in line.map { $0 } }
    }
}

struct CustomError: Error {}
