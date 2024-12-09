enum Direction {
  case up
  case down
  case right
  case left
  
  var position: Position {
    switch self {
    case .up: Position(0, -1)
    case .down: Position(0, 1)
    case .right: Position(1, 0)
    case .left: Position(-1, 0)
    }
  }
  
  var next: Direction {
    switch self {
    case .up: .right
    case .down: .left
    case .right: .down
    case .left: .up
    }
  }
}
