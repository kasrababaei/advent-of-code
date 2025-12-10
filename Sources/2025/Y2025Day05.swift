import Algorithms
import Foundation

struct Y2025Day05: AdventDay {
  var data: String
  
  func part1() -> Any {
    var ranges = Set<ClosedRange<Int>>()
    let lines = data.split(separator: "\n")
    return lines.reduce(into: 0) { res, line in
      let range = line.matches(of: /(\d+)-(\d+)/)
      if range.count > 0,
         let lowerBound = try? range[0].output.1.toInteger(),
         let upperBound = try? range[0].output.2.toInteger() {
        ranges.insert(lowerBound...upperBound)
      } else if let value = try? line.toInteger(), ranges.contains(where: { $0.contains(value) }) {
        res += 1
      }
    }
  }
  
  func part2() -> Any {
    var ranges = [ClosedRange<Int>]()
    
    for line in data.split(separator: "\n") {
      let matches = line.matches(of: /(\d+)-(\d+)/)
      guard matches.count > 0 else { break }
      let output = matches[0].output
      let lowerBound = try! output.1.toInteger()
      let upperBound = try! output.2.toInteger()
      let range = lowerBound...upperBound
      ranges.append(range)
    }
    
    ranges.sort(by: { $0.lowerBound < $1.lowerBound })
    
    var mergedRanges: [ClosedRange<Int>] = [ranges[0]]
    var index = 1
    while index < ranges.count {
      defer { index += 1 }
      let candidate = ranges[index]
      if let last = mergedRanges.last, last.upperBound >= candidate.lowerBound - 1 {
        mergedRanges[mergedRanges.endIndex - 1] = last.lowerBound...max(last.upperBound, candidate.upperBound)
      } else {
        mergedRanges.append(candidate)
      }
    }
    
    return mergedRanges
      .reduce(into: 0) { result, range in
        let delta = range.upperBound - range.lowerBound + 1
        result += delta
      }
  }
}
