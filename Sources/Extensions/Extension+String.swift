extension Character {
    var int: Int {
        get throws {
            try "\(self)".int
        }
    }
}

extension Substring {
    var int: Int {
        get throws {
            try "\(self)".int
        }
    }
}

extension String {
    var int: Int {
        get throws {
            guard let value = Int(self) else {
                throw CustomError()
            }
            
            return value
        }
    }
}

struct CustomError: Error {}
