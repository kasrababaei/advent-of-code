import Testing
@testable import AdventOfCode

struct Y2024Day09Tests {
  let testData = """
  """
    
  @Test func testPart1() async throws {
    let testData = """
    """
    #expect(try Y2024Day09(data: testData).part1() as! Int == 0)
    #expect(try Y2024Day09().part1() as! Int == 0)
  }
  
  @Test func testPart2() async throws {
    let testData = """
    """
    #expect(try Y2024Day09(data: testData).part2() as! Int == 0)
    #expect(try Y2024Day09().part2() as! Int == 0)
  }
}

