import Testing
@testable import AdventOfCode

struct Y2025Day03Tests {
  let testData = """
987654321111111
811111111111119
234234234234278
818181911112111
"""

  @Test func testPart1() async throws {
    #expect(Y2025Day03(data: testData).part1() as! Int == 357)
    #expect(Y2025Day03().part1() as! Int == 17613)
  }

  @Test func testPart2() async throws {
    #expect(Y2025Day03(data: testData).part2() as! Int == 3121910778619)
    #expect(Y2025Day03().part2() as! Int == 175304218462560)
  }
}
