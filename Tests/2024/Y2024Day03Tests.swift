import Testing
@testable import AdventOfCode

struct Y2024Day03Tests {
  @Test func testPart1() async throws {
    let testData = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    #expect(try Y2024Day03(data: testData).part1() as! Int == 161)
    #expect(try Y2024Day03().part1() as! Int == 170778545)
  }
  
  @Test func testPart2() async throws {
    let testData = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
    #expect(try Y2024Day03(data: testData).part2() as! Int == 48)
    #expect(try Y2024Day03().part2() as! Int == 82868252)
  }
}

