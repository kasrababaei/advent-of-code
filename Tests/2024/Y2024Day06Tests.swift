import Testing
@testable import AdventOfCode

struct Y2024Day06Tests {
  let testData = """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """
    
  @Test func testPart1() async throws {
    let testResult = try Y2024Day06(data: testData).part1() as! Int
    #expect(testResult == 41)
    
    let inputResult = try Y2024Day06().part1() as! Int
    #expect(inputResult == 4903)
  }
  
  @Test func testPart2() async throws {
    let testResult = try Y2024Day06(data: testData).part2() as! Int
    #expect(testResult == 6)
    
    let inputResult = try Y2024Day06().part2() as! Int
    #expect(inputResult == 1911)
  }
}

