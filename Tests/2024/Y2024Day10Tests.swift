import Testing
@testable import AdventOfCode

struct Y2024Day10Tests {
  let testData = """
  89010123
  78121874
  87430965
  96549874
  45678903
  32019012
  01329801
  10456732
  """
    
  @Test func testPart1() async throws {
    let testResult = try Y2024Day10(data: testData).part1() as! Int
    #expect(testResult == 36)
    
//    let inputResult = try Y2024Day10().part1() as! Int
//    #expect(inputResult == 0)
  }
  
  @Test func testPart2() async throws {
    let testData = """
    """
    #expect(try Y2024Day10(data: testData).part2() as! Int == 0)
    #expect(try Y2024Day10().part2() as! Int == 0)
  }
}

