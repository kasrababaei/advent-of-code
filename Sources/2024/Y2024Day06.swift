import Foundation
import RegexBuilder

struct Y2024Day06: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    let (origin, dict) = metadata()
    var visited: Set<Position> = [origin]
    var current = origin
    var next = origin
    var direction = Direction.up
    
    while dict[next] != nil {
      next = current + direction.position
      if [".", "^"].contains(dict[next]) {
        current = next
        visited.insert(current)
      } else {
        direction = direction.next
      }
    }
    
    return visited.count
  }
  
  func part2() throws -> Any {
    let metadata = metadata()
    var map = metadata.map
    
    var current = metadata.origin
    var next = metadata.origin
    var direction = Direction.up
    
    var moves: Set<Move> = [Move(current, direction)]
    var visited: Set<Position> = [current]
    var visitedCount = visited.count
    
    var previouslyBlocked: Set<Position> = []
    var loops: Set<Move> = []
    
    while true {
      var isBlocking = false
      var currentBlockingPosition: Position? = nil
      
      while map[next] != nil {
        next = current + direction.position
        
        let canBlock = !previouslyBlocked.contains(next)
        && map[next] == "."
        && !isBlocking
        && map[next] != nil
        
        if canBlock {
          previouslyBlocked.insert(next)
          currentBlockingPosition = next
          map[next] = "O"
          isBlocking = true
        }
        
        if [".", "^"].contains(map[next]) {
          current = next
          visited.insert(current)
          
          guard moves.insert(Move(current, direction)).inserted else {
            // Same position and same direction means it's a loop.
            break
          }
        } else {
          direction = direction.next
        }
      }
      
      if map[next] != nil, let currentBlockingPosition {
        loops.insert(Move(currentBlockingPosition, direction))
      }
      
      if visitedCount == visited.count, !isBlocking {
        // Exhausted all the moves.
        break
      } else {
        visitedCount = visited.count
      }
      
      // Reset, try again...
      current = metadata.origin
      next = current
      direction = .up
      isBlocking = false
      currentBlockingPosition.map { map[$0] = "." }
      moves.removeAll()
    }
    
    return loops.count
  }
  
  private func metadata() -> (origin: Position, map: [Position: Character]) {
    var origin = Position(0, 0)
    
    let dict = data.split(separator: "\n")
      .enumerated()
      .flatMap { (y, line) in
        Array(line).enumerated().map { (x, char) in
          if char == "^" {
            origin = Position(x, y)
          }
          let p = Position(x, y)
          return (p, char)
        }
      }
      .reduce(into: [Position: Character]()) { $0[$1.0] = $1.1 }
    
    return (origin, dict)
  }
}
