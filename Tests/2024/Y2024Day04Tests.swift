import Testing
@testable import AdventOfCode

struct Y2024Day04Tests {
  let testData = """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """
  
  @Test func testPart1() async throws {
    let testDataResult = try Y2024Day04(data: testData).part1() as! Int
    #expect(testDataResult == 18)
    
    let realDataResult = try Y2024Day04().part1() as! Int
    #expect(realDataResult == 2583)
  }
  
  @Test func diagonals() throws {
    let testData = """
    abcx
    defy
    ghjz
    opqr
    """
    
    let expected = Set(["a", "aejr", "bfz", "cy", "x", "dhq", "gp", "o", "bd", "ceg", "xfho", "yjp", "zq", "r"])
    let result = Set(try testData.diagonals())
    let diff = expected.symmetricDifference(result)
    
    #expect(diff.isEmpty)
  }
  
  @Test func testPart2() async throws {
    let testDataResult = try Y2024Day04(data: testData).part2() as! Int
    #expect(testDataResult == 9)
    
    let realDataResult = try Y2024Day04().part2() as! Int
    #expect(realDataResult == 1978)
  }
}

