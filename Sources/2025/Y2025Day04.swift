import Algorithms
import Foundation

struct Y2025Day04: AdventDay {
  var data: String
  
  func part1() -> Any {
    let matrix = data.to2DArray()
    let rows = matrix.count
    let columns = matrix[0].count
    
    return (0..<rows)
      .reduce(into: 0) { count, row in
        count += (0..<columns)
          .reduce(into: 0) { res, column in
            guard matrix[row][column] == "@" else { return }
            let count = matrix.adjacentNeighbours(row: row, column: column)
              .filter { $0 == "@" }
              .count
            
            res += count < 4 ? 1 : 0
          }
      }
  }
  
  func part2() -> Any {
    var matrix = data.to2DArray()
    let rows = matrix.count
    let columns = matrix[0].count
    
    var count = 0
    func findPaperRolls() {
      let papers: [(Int, Int)] = (0..<rows)
        .flatMap { row -> [(Int, Int)] in
          (0..<columns)
            .compactMap { column -> (Int, Int)? in
              guard matrix[row][column] == "@" else { return nil }
              if matrix.adjacentNeighbours(row: row, column: column).filter({ $0 == "@" }).count < 4 {
                count += 1
                return (row, column)
              }
              
              return nil
            }
        }
      
      for (row, column) in papers {
        matrix[row][column] = "."
      }
      
      if !papers.isEmpty {
        findPaperRolls()
      }
    }
    
    findPaperRolls()
    
    return count
  }
}

private extension Array where Element == [Character] {
  func adjacentNeighbours(row: Int, column: Int) -> [Character] {
    let directions = [(0, -1), (-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1)]

    return directions
      .compactMap { i, j in
        guard indices.contains(i + row) else { return nil }
        guard first?.indices.contains(j + column) == true else { return nil }
        return self[i + row][j + column]
      }
  }
}
