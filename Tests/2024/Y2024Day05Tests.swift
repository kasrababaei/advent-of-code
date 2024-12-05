import Testing
@testable import AdventOfCode

struct Y2024Day05Tests {
  let testData = """
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
  """
    
  @Test func testPart1() async throws {
    let testResult = try Y2024Day05(data: testData).part1() as! Int
    #expect(testResult == 143)
    
    let inputResult = try Y2024Day05().part1() as! Int
    #expect(inputResult == 5509)
  }
  
  @Test func testPart2() async throws {
    let testResult = try Y2024Day05(data: testData).part2() as! Int
    #expect(testResult == 123)
    
    let inputResult = try Y2024Day05().part2() as! Int
    #expect(inputResult == 4407)
  }
}

