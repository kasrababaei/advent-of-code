import Testing
@testable import AdventOfCode

struct Y2024Day09Tests {
  let testData = """
  2333133121414131402
  """
    
  @Test func testPart1() async throws {
    let testData = """
    12345
    """
    
    let testResult = try Y2024Day09(data: testData).part1() as! Int
    #expect(testResult == 1928)
    
    let inputResult = try Y2024Day09().part1() as! Int
    #expect(inputResult == 0)
  }
  
  @Test func testPart2() async throws {
    let testData = """
    """
    
    let testResult = try Y2024Day09(data: testData).part2() as! Int
    #expect(testResult == 0)
    
    let inputResult = try Y2024Day09().part2() as! Int
    #expect(inputResult == 0)
  }
}

