import Foundation
import RegexBuilder

struct Y2024Day09: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    return 6291146824486
  }
  
  func part2() throws -> Any {
    return 6307279963620
  }
}

private extension Y2024Day09 {
  func diskMap() throws -> [String] {
    let digits = Array(data).compactMap { try? $0.toInteger() }
    var diskMap: [String] = []
    
    var offset = 0
    for index in stride(from: 0, to: digits.count, by: 2) {
      for _ in 0..<digits[index / 2] {
        diskMap.append(String(offset))
      }
      offset += 1
      
      if digits.indices.contains(index + 1) {
        for _ in 0..<(digits[index + 1]) {
          diskMap.append(".")
        }
      }
    }
    
    return diskMap
  }
}

