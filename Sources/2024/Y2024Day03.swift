import Foundation
import RegexBuilder

struct Y2024Day03: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    try data
      .matches(of: /mul\((\d{1,3}),(\d{1,3})\)/)
      .reduce(into: 0) { result, matches in
        result += try matches.output.1.toInteger() * matches.output.2.toInteger()
      }
  }
  
  func part2() throws -> Any {
    var enabled = true
    
    return try data
      .matches(of: /((do\(\))|(don't\(\))|mul\((\d{1,3}),(\d{1,3})\))/)
      .reduce(into: 0) { result, matches in
        if matches.output.2 != nil { enabled = true }
        if matches.output.3 != nil { enabled = false }
        if enabled, let left = matches.output.4, let right = matches.output.5 {
          result += try left.toInteger() * right.toInteger()
        }
      }
  }
}
