import Foundation
import RegexBuilder

struct Y2024Day04: AdventDay {
  let data: String
  let lines: [Substring]
  
  init(data: String) {
    self.data = data
    self.lines = data.split(separator: "\n")
  }
  
  func part1() throws -> Any {
    let regex = /XMAS/
    let horizontal = sum(lines.map { "\($0)" }, regex: regex)
    let vertical = sum(vertical(), regex: regex)
    let diagonals = try data.diagonals().filter { $0.count > 3 }
    let diagonalsSum = sum(diagonals, regex: regex)
    
    return horizontal + vertical + diagonalsSum
  }
  
  private func vertical() -> [String] {
    let maxRow = lines.count - 1
    let maxColumn = lines[0].count - 1
    
    return (0...maxColumn)
      .reduce(into: [String]()) { result, columnIndex in
        let verticalLine = (0...maxRow)
          .reduce(into: "") { result, rowIndex in
            let line = lines[rowIndex]
            let index = line.index(line.startIndex, offsetBy: columnIndex)
            let character = line[index]
            result = "\(result)\(character)"
          }
        
        result.append(verticalLine)
      }
  }
  
  
  
  func sum(_ lines: [String], regex: Regex<Substring>) -> Int {
    lines.reduce(into: 0) { sum, line in
      let matches = line.matches(of: regex)
      let count = matches.count
      
      sum += count
      let _matches = line.matches(of: /SAMX/)
      let _count = _matches.count
      
      sum += _count
    }
  }
  
  func part2() throws -> Any {
    let grid = data.to2DArray()
    let size = grid.count
    var output: [[Character]] = Array(repeating: Array(repeating: Character("."), count: size), count: size)
    
    var sum = 0
    for row in 0..<size {
      for column in 0..<size {
        if x(row, column) {
          output[row][column] = grid[row][column]
          output[row - 1][column - 1] = grid[row - 1][column - 1]
          output[row - 1][column + 1] = grid[row - 1][column + 1]
          output[row + 1][column - 1] = grid[row + 1][column - 1]
          output[row + 1][column + 1] = grid[row + 1][column + 1]
          
          sum += 1
        }
      }
    }
    
    output.prettyPrint()
    func x(_ row: Int, _ column: Int) -> Bool {
      guard [row, column].allSatisfy({ 0..<size ~= $0 }) else { return false }
      guard grid[row][column] == "A" else { return false }
      let center = grid[row][column]
      
      guard [
        row - 1, column - 1,
        row - 1, column + 1,
        row + 1, column - 1,
        row + 1, column + 1
      ].allSatisfy({ 0..<size ~= $0 })
      else { return false }
      
      let topLeft = grid[row - 1][column - 1]
      let topRight = grid[row - 1][column + 1]
      let bottomLeft = grid[row + 1][column - 1]
      let bottomRight = grid[row + 1][column + 1]
      
      let firstX = "\(topLeft)\(center)\(bottomRight)"
      let secondX = "\(topRight)\(center)\(bottomLeft)"
      let a = ["MAS", "SAM"].contains(firstX)
      let b = ["MAS", "SAM"].contains(secondX)
      return a && b
    }
    
    return sum
  }
}

extension String {
  func diagonals() throws -> [String] {
    let grid = self.to2DArray()
    
    guard grid[0].count ==  grid.count else {
      struct LengthError: Error {}
      throw LengthError()
    }
    
    let size = grid.count
    var diagonals: [String] = []
    
    // Collect all left-to-right diagonals
    for startColumn in 0..<size {
      var diagonal = ""
      var row = 0
      var col = startColumn
      while row < size, col < size {
        diagonal.append(grid[row][col])
        row += 1
        col += 1
      }
      if !diagonal.isEmpty {
        diagonals.append(diagonal)
      }
    }
    
    for startRow in 1..<size {
      var diagonal = ""
      var row = startRow
      var col = 0
      while row < size, col < size {
        diagonal.append(grid[row][col])
        row += 1
        col += 1
      }
      if !diagonal.isEmpty {
        diagonals.append(diagonal)
      }
    }
    
    // Collect all right-to-left diagonals
    for startColumn in (0..<size).reversed() {
      var diagonal = ""
      var row = 0
      var col = startColumn
      while row < size, col >= 0 {
        diagonal.append(grid[row][col])
        row += 1
        col -= 1
      }
      if !diagonal.isEmpty {
        diagonals.append(diagonal)
      }
    }
    
    for startRow in 1..<size {
      var diagonal = ""
      var row = startRow
      var col = size - 1
      while row < size, col >= 0 {
        diagonal.append(grid[row][col])
        row += 1
        col -= 1
      }
      if !diagonal.isEmpty {
        diagonals.append(diagonal)
      }
    }
    
    return diagonals
  }
}
