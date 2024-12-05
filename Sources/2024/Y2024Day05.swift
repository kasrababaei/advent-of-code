import Foundation
import RegexBuilder

struct Y2024Day05: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    let (rules, pages) = try input()
    
    var sum = 0
    for page in pages {
      var isValid = true
      for index in (0..<page.count).reversed() where isValid {
        let precedingRules = page[0..<index]
        guard let forbiddenYs = rules[page[index]] else { continue }
        isValid = Set(forbiddenYs).intersection(precedingRules).isEmpty
      }
      
      if isValid {
        sum += page[page.count / 2]
      }
    }
    
    return sum
  }
  
  func part2() throws -> Any {
    let (rules, pages) = try input()
    
    var invalidPages: [[Int]] = []
    var sum = 0
    
    for page in pages {
      var isValid = true
      for index in (0..<page.count).reversed() where isValid {
        let precedingRules = page[0..<index]
        guard let forbiddenYs = rules[page[index]] else { continue }
        isValid = Set(forbiddenYs).intersection(precedingRules).isEmpty
      }
      
      if !isValid {
        invalidPages.append(page)
      }
    }
    
    for page in invalidPages {
      var mutatingPage = page
      var index = mutatingPage.count - 1
      
      while index >= 0 {
        let precedingRules = mutatingPage[0..<index]
        guard let forbiddenYs = rules[mutatingPage[index]],
              !Set(forbiddenYs).intersection(precedingRules).isEmpty
        else {
          index -= 1
          continue
        }
        
        let lastIndex = precedingRules.lastIndex(where: { forbiddenYs.contains($0) })!
        mutatingPage.swapAt(index, lastIndex)
        index = mutatingPage.count - 1
      }
      
      sum += mutatingPage[mutatingPage.count / 2]
    }
    
    return sum
  }
  
  private func input() throws -> (rules: [Int: [Int]], pages: [[Int]]) {
    let split = data.split(separator: "\n\n")
    let rules = try split[0]
      .split(separator: "\n")
      .map { line in
        let x = try line.split(separator: "|")[0].toInteger()
        let y = try line.split(separator: "|")[1].toInteger()
        return (x, y)
      }
      .reduce(into: [Int: [Int]]()) { $0[$1.0, default: []].append($1.1) }
    
    let pages = try split[1]
      .split(separator: "\n")
      .map { line in
        try line.split(separator: ",").map { try $0.toInteger() }
      }
    
    return (rules, pages)
  }
}
