import Testing
@testable import AdventOfCode

struct Y2024Day09Tests {
  let testData = """
  2333133121414131402
  """
    
  @Test func testPart1() async throws {
    let inputResult = try Y2024Day09().part1() as! Int
    #expect(inputResult == 6291146824486)
  }
  
  @Test func testPart2() async throws {
    let inputResult = try Y2024Day09().part2() as! Int
    #expect(inputResult == 6307279963620)
  }
}

