import Foundation

struct Y2024Day01: AdventDay {
  let data: String
  
  
  func part1() -> Any {
    let (left, right) = locationPairs()
    
    return zip(left, right)
      .map { abs($0 - $1) }
      .sum
  }
  
  func part2() -> Any {
    let (left, right) = locationPairs()
    
    let counter = NSCountedSet()
    right.forEach { counter.add($0) }
    
    return left.map { $0 * counter.count(for: $0) }.sum
  }
  
  func locationPairs() -> ([Int], [Int]) {
    let regex = /(\d*)\s*(\d*)/
    let lines = data.split(separator: "\n")
    
    let (left, right) = lines.reduce(into: ([Int](), [Int]())) { result, line in
      let match = line.firstMatch(of: regex)!.output
      result.0.append(Int(match.1)!)
      result.1.append(Int(match.2)!)
    }
    
    guard left.count == right.count else { fatalError("Unequal lengths.") }
    
    return (left.sorted(by: >), right.sorted(by: >))
  }
}
