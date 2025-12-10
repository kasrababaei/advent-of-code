import Testing
@testable import AdventOfCode

struct Y2025Day05Tests {
  let testData = """
3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""

  @Test func testPart1() async throws {
    #expect(Y2025Day05(data: testData).part1() as! Int == 3)
    #expect(Y2025Day05().part1() as! Int == 698)
  }

  @Test func testPart2() async throws {
    #expect(Y2025Day05(data: testData).part2() as! Int == 14)
    #expect(Y2025Day05().part2() as! Int == 352807801032167)
  }
}
