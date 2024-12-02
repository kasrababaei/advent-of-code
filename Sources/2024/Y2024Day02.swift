import Foundation

struct Y2024Day02: AdventDay {
  let data: String
  var reports: [[Int]] {
    data.split(separator: "\n")
      .map { line in
        line.split(separator: " ").compactMap { try? $0.toInteger() }
      }
  }
  
  func part1() -> Any {
    return reports
      .reduce(into: 0) { count, levels in
        let isSafe = validateSafetyOfLevels(levels, order: <)
        || validateSafetyOfLevels(levels, order: >)
        
        if isSafe { count += 1 }
      }
  }
  
  func part2() -> Any {
    return reports
      .reduce(into: 0) { count, levels in
        let isSafe = validateSafetyOfLevels(levels, canTolerate: true, order: <)
        || validateSafetyOfLevels(levels, canTolerate: true, order: >)
        
        if isSafe { count += 1 }
      }
  }
  
  private func validateSafetyOfLevels(
    _ levels: [Int],
    canTolerate: Bool = false,
    order: @escaping ((Int, Int)) -> Bool
  ) -> Bool {
    var hasTolerated = false
    guard var last = levels.first else { return false }
    
    var levels = levels
    var index = 1
    
    while index < levels.count {
      let current = levels[index]
      
      let isSafe: (Int, Int) -> Bool = {
        order(($0, $1))
        && levels.hasSafeDiff(from: index - 1, to: index)
        && levels.hasSafeDiff(from: index + 1, to: index)
      }
      
      if isSafe(last, current) {
        last = current
        index += 1
      } else if canTolerate, !hasTolerated {
        hasTolerated = true
        
        let mutatedLevels = [
          levels.removing(at: levels.clamped(index - 1)),
          levels.removing(at: levels.clamped(index)),
          levels.removing(at: levels.clamped(index + 1))
        ].lazy
        
        if let mutatedLevel = mutatedLevels.first(where: { validateSafetyOfLevels($0, order: order) }) {
          levels = mutatedLevel
          last = levels[levels.clamped(index)]
          index += 1
        }
      } else {
        return false
      }
    }
    
    return true
  }
}

private extension Array<Int> {
  func hasSafeDiff(from index: Int, to nextIndex: Int) -> Bool {
    guard indices.contains(index), indices.contains(nextIndex) else { return true }
    let diff = abs(self[index] - self[nextIndex])
    return diff > 0 && diff < 4
  }
}
