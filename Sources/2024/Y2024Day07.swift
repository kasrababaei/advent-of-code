import Foundation
import RegexBuilder

struct Y2024Day07: AdventDay {
  enum Operation {
    case add
    case multiply
  }
  
  let data: String
  
  func part1() async throws -> Any {
    try await sumValidEquation(canConcatenate: false)
  }
  
  func part2() async throws -> Any {
    try await sumValidEquation(canConcatenate: true)
  }
}

// MARK: - Private Functions
private extension Y2024Day07 {
  func sumValidEquation(canConcatenate: Bool) async throws -> Int {
    let equations = try equations()
    return await withTaskGroup(of: Int.self, returning: Int.self) { group in
      var values = 0
      
      for equation in equations {
        group.addTask {
          isValid(Array(equation[1...]), result: equation[0], canConcatenate: canConcatenate) ? equation[0] : 0
        }
      }
      
      for await value in group {
        values += value
      }
      
      return values
    }
  }
  
  func isValid(_ array: [Int], result: Int, canConcatenate: Bool) -> Bool {
    func backtrack(_ currentResult: Int, _ index: Int) -> Bool {
      if index == array.count {
        return currentResult == result
      }
      
      if backtrack(currentResult + array[index], index + 1) {
        return true
      }
      
      if backtrack(currentResult * array[index], index + 1) {
        return true
      }
      
      if canConcatenate {
        let tenFactor = (0..<String(array[index]).count).reduce(into: 1) { res, _ in res *= 10 }
        let concatenated = currentResult * tenFactor + array[index]
        
        if backtrack(concatenated, index + 1) {
          return true
        }
      }
      
      return false
    }
    
    return backtrack(array[0], 1)
  }
  
  func equations() throws -> [[Int]] {
    let regex = Regex {
      TryCapture {
        OneOrMore(.digit)
      } transform: { try $0.toInteger() }
      ":"
      TryCapture {
        Repeat(1...) {
          One(.whitespace)
          OneOrMore(.digit)
        }
      } transform: { try $0.split(separator: " ").map { try $0.toInteger() } }
    }
    
    return data
      .split(separator: "\n")
      .flatMap { line in
        line.matches(of: regex).map { [$0.output.1] + $0.output.2 }
      }
  }
}
