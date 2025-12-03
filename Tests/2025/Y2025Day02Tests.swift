import Testing
@testable import AdventOfCode

struct Y2025Day02Tests {
  let testData = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"""

  @Test func testPart1() async throws {
    #expect(Y2025Day02(data: testData).part1() as! Int == 1227775554)
    #expect(Y2025Day02().part1() as! Int == 23560874270)
  }

  @Test func testPart2() async throws {
    #expect(Y2025Day02(data: testData).part2() as! Int == 4174379265)
    #expect(Y2025Day02().part2() as! Int == 44143124633)
  }
}
