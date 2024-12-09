struct Move: Hashable {
  let position: Position
  let direction: Direction
  
  init(_ position: Position, _ direction: Direction) {
    self.position = position
    self.direction = direction
  }
  
  init(_ x: Int, _ y: Int, _ direction: Direction) {
    self.position = Position(x, y)
    self.direction = direction
  }
}

