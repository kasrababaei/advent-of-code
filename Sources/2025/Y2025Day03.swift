import Algorithms
import Foundation

struct Y2025Day03: AdventDay {
  var data: String

  func part1() -> Any {
      data.split(separator: "\n")
          .compactMap { line in
              guard line.count > 2 else {
                  return Int("\(line)")
              }

              let array = line.compactMap { Int("\($0)") }
              var lhs = 0
              var rhs = 1
              var value: Int { array[lhs] * 10 + array[rhs] }

              for index in 2..<array.count {
                  let a = array[rhs] * 10 + array[index]
                  let b = array[lhs] * 10 + array[index]

                  if a > value {
                      lhs = rhs
                      rhs = index
                  } else if b > value {
                      rhs = index
                  }
              }

              return value
          }
          .sum
  }

  func part2() -> Any {
      data.split(separator: "\n")
          .compactMap { line in
              var values =  Array(repeating: 0, count: 12)
              var numbers = Array(line).compactMap { Int("\($0)") }

              for offset in stride(from: 12, to: 0, by: -1) {
                  var tempIndex = 0
                  for index in 0...numbers.count - offset {
                      if numbers[index] > values[12 - offset] {
                          tempIndex = index
                          values[12 - offset] = numbers[index]
                      }
                  }

                  numbers = Array(numbers[(tempIndex + 1)...])
              }

              return Int(values.map { String($0) }.joined())
          }
          .sum
  }
}
