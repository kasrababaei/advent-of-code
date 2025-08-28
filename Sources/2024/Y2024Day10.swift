import Foundation
import RegexBuilder

struct Y2024Day10: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    let (zeros, map) = try map()
    var sum = 0
    
    for zero in zeros.sorted() {
      if map.validHikes(from: zero, facing: .left) != nil {
        sum += 1
      }
      
      if map.validHikes(from: zero, facing: .down) != nil {
        sum += 1
      }
      
      if map.validHikes(from: zero, facing: .right) != nil {
        sum += 1
      }
    }
    
    return sum
  }
  
  func part2() throws -> Any {
    return 0
  }
}

private extension Y2024Day10 {
  func map() throws -> (zeros: Set<Position>, map: [Position: Int]) {
    var zeros: Set<Position> = []
    let map = try data
      .split(separator: "\n")
      .enumerated()
      .flatMap { (y, line) in
        try line
          .enumerated()
          .map { (x, value) in
            let position = Position(x, y)
            let digit = try value.toInteger()
            if digit == 0 {
              zeros.insert(Position(x, y))
            }
            
            return (position, digit)
          }
      }
      .reduce(into: [Position: Int]()) { $0[$1.0] = $1.1 }
    
    return (zeros, map)
  }
}

private extension [Position: Int] {
  func prettyPrint() {
    var y = 0
    var string = ""
    
    for (position, digit) in self.sorted(by: { $0.key < $1.key }) {
      if position.y != y {
        y = position.y
        print(string)
        string = ""
      }
      string += "\(digit)"
    }
    
    print(string)
  }
  
  func validHikes(
    from origin: Position,
    facing direction: Direction
  ) -> Int? {
    // Initial move
    let initialMovePosition = origin.move(direction)
    guard isUphill(from: origin, to: initialMovePosition) else {
      return 0
    }
    
    // var queue: [Move] = []
    
    
    
    var trail: [Position] = [origin, initialMovePosition]
    var count = trail.count
    
    var currentPosition = initialMovePosition
    while true {
      for direction in Direction.uphill {
        let next = currentPosition.move(direction)
        if isUphill(from: currentPosition, to: next) {
          trail.append(next)
          currentPosition = next
          break
        }
      }
      
      guard self[trail.last!]! - self[trail[trail.count - 2]]! == 1, trail.count > count else {
        // let values = trail.compactMap { self[$0] }
        // print(values)
        return nil
      }
      
      if self[trail.last!]! == 9 {
        // return currentPosition
        return Int.max
      }
      
      count = trail.count
    }
    
    return nil
  }
  
  func isUphill(from origin: Position, to next: Position) -> Bool {
    self[next] != nil && self[next]! - self[origin]! == 1
  }
}

private extension Position {
  func move(_ direction: Direction) -> Position {
    self + direction.position
  }
}

private extension Direction {
  static var uphill: [Direction] {
    [.left, .down, .right]
  }
}
