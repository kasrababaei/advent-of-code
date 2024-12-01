import Testing
@testable import AdventOfCode

struct Y2024Day01Tests {
  let testData = """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """
  
  @Test func testPart1() async throws {
    #expect(Y2024Day01(data: testData).part1() as! Int == 11)
    #expect(Y2024Day01().part1() as! Int == 1341714)
  }
  
  @Test func testPart2() async throws {
    #expect(Y2024Day01(data: testData).part2() as! Int == 31)
    #expect(Y2024Day01().part2() as! Int == 27384707)
  }
}
