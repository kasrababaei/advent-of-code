import Testing
@testable import AdventOfCode

struct Y2025Day01Tests {
  let testData = """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""

  @Test func testPart1() async throws {
    #expect(Y2025Day01(data: testData).part1() as! Int == 3)
    #expect(Y2025Day01().part1() as! Int == 1141)
  }

  @Test func testPart2() async throws {
    #expect(Y2025Day01(data: testData).part2() as! Int == 6)
    #expect(Y2025Day01().part2() as! Int == 6634)
  }
}
