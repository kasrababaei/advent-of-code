struct Position: Hashable {
  let x: Int
  let y: Int
  
  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
}

infix operator +: AdditionPrecedence
extension Position {
  static func + (lhs: Position, rhs: Position) -> Position {
    Position(lhs.x + rhs.x, lhs.y + rhs.y)
  }
}

infix operator -: AdditionPrecedence
extension Position {
  static func - (lhs: Position, rhs: Position) -> Position {
    Position(lhs.x - rhs.x, lhs.y - rhs.y)
  }
}
  
extension Position {
  func mirror(_ position: Position) -> Position {
    let delta = self - position
    return self + delta
  }
}

extension Position: Comparable {
  static func < (lhs: Position, rhs: Position) -> Bool {
    if lhs.y != rhs.y {
      return lhs.y < rhs.y
    }
    return lhs.x < rhs.x
  }
}
