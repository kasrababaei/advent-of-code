import Testing
@testable import AdventOfCode

struct Y2024Day02Tests {
  let testData = """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """
  
  @Test func testPart1() async throws {
    #expect(Y2024Day02(data: testData).part1() as! Int == 2)
    #expect(Y2024Day02().part1() as! Int == 332)
  }
  
  @Test func testPart2() async throws {
    #expect(Y2024Day02(data: testData).part2() as! Int == 4)
     #expect(Y2024Day02().part2() as! Int == 398)
  }
}

