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
}

struct CustomError: Error {}
