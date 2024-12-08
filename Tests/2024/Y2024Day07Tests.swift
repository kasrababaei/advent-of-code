import Testing
@testable import AdventOfCode

struct Y2024Day07Tests {
  let testData = """
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
  """
    
  @Test func testPart1() async throws {
    let testResult = try await Y2024Day07(data: testData).part1() as! Int
    #expect(testResult == 3749)
    
    let inputResult = try await Y2024Day07().part1() as! Int
    #expect(inputResult == 5512534574980)
  }
  
  @Test func testPart2() async throws {
    let testResult = try await Y2024Day07(data: testData).part2() as! Int
    #expect(testResult == 11387)
    
    let inputResult = try await Y2024Day07().part2() as! Int
    #expect(inputResult == 328790210468594)
  }
}
