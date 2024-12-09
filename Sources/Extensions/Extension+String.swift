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
  
  func charAt(_ index: Int) -> Character {
    let startIndex = self.index(startIndex, offsetBy: index)
    return self[startIndex]
  }
  
  func map() -> [Character: [Position]] {
    split(separator: "\n")
      .enumerated()
      .flatMap { (y, line) in
        line
          .enumerated()
          .map { (x, char) -> (Character, Position) in
            return (char, Position(x, y))
          }
      }
      .reduce(into: [Character: [Position]]()) { res, tuple in
        res[tuple.0, default: []].append(tuple.1)
      }
  }
}

struct CustomError: Error {}
