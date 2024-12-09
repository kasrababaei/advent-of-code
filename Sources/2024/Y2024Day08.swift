import Foundation
import RegexBuilder

struct Y2024Day08: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    let map = data.map()
    let allPositions: Set<Position> = map.values.reduce(into: Set<Position>()) { $0 = $0.union($1) }
    var antinodes: Set<Position> = []
    
    for antenna in map where antenna.key != "." {
      let positions = antenna.value
      
      for index in 0..<positions.count - 1 {
        let current = positions[index]
        
        for nextIndex in (index + 1)..<positions.count {
          let next = positions[nextIndex]
          
          if allPositions.contains(current.mirror(next)) {
            antinodes.insert(current.mirror(next))
          }
          
          if allPositions.contains(next.mirror(current)) {
            antinodes.insert(next.mirror(current))
          }
        }
      }
    }
    
    return antinodes.count
  }
  
  func part2() throws -> Any {
    let map = data.map()
    let allPositions: Set<Position> = map.values.reduce(into: Set<Position>()) { $0 = $0.union($1) }
    var antinodes: Set<Position> = []
    
    for antenna in map where antenna.key != "." {
      let positions = antenna.value
      antinodes.formUnion(positions)
      
      for index in 0..<positions.count - 1 {
        let current = positions[index]
        
        for nextIndex in (index + 1)..<positions.count {
          let next = positions[nextIndex]
          
          let deltaC = current - next
          var _next = current + deltaC
          while allPositions.contains(_next) {
            antinodes.insert(_next)
            _next = _next + deltaC
          }
          
          let deltaN = next - current
          _next = next + deltaN
          while allPositions.contains(_next) {
            antinodes.insert(_next)
            _next = _next + deltaN
          }
        }
      }
    }
    
    return antinodes.count
  }
}

// MARK: - Private Functions
private extension Y2024Day08 {}
