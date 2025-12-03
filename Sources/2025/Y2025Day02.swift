import Algorithms
import Foundation

struct Y2025Day02: AdventDay {
  var data: String

  func part1() -> Any {
    let lines = data.split(separator: ",")
    let regex = /(\d+)-(\d+)/
    let invalidIDs = lines.flatMap { line in
      let outputs = line.matches(of: regex)[0]
      let lowerBound = Int(outputs.1)!
      let upperBound = Int(outputs.2)!

      return (lowerBound...upperBound).compactMap { value in
        let string = "\(value)"
        if string.count % 2 == 0 {
          let mid = string.count / 2
          let lhs = string[string.startIndex...string.index(string.startIndex, offsetBy: mid - 1)]
          if "\(lhs)\(lhs)" == string {
            return value
          }
        }

        return nil
      }
    }

    return invalidIDs.sum
  }

  func part2() -> Any {
    let lines = data.split(separator: ",")
    let regex = /(\d+)-(\d+)/
    return lines.map { line in
      let outputs = line.matches(of: regex)[0]
      let lowerBound = Int(outputs.1)!
      let upperBound = Int(outputs.2)!

      return (lowerBound...upperBound)
        .filter { $0 > 9 }
        .reduce(into: 0) { result, value in
          let string = String(value)
          var ids = Set<Int>()

          for length in 1...string.count / 2 {
            let startIndex = string.startIndex
            let endIndex = string.index(startIndex, offsetBy: length)
            let slice = string[startIndex..<endIndex]
            let candidate = Array(repeating: slice, count: string.count / length).joined()
            if candidate == string, ids.insert(value).inserted {
              result += value
            }
          }
        }
    }.sum
  }
}
