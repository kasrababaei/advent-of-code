import Testing
@testable import AdventOfCode

struct Y2025Day04Tests {
  let testData = """
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

  @Test func testPart1() async throws {
    #expect(Y2025Day04(data: testData).part1() as! Int == 13)
    #expect(Y2025Day04().part1() as! Int == 1478)
  }

  @Test func testPart2() async throws {
    #expect(Y2025Day04(data: testData).part2() as! Int == 43)
    #expect(Y2025Day04().part2() as! Int == 9120)
  }
}
