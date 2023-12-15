import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase {
    let testData = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """
    
    var part2TestData: String { testData }
    
    func testPart1TestData() throws {
        let challenge = Day11(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "374")
    }
    
    func testPart1() throws {
        let challenge = Day11()
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "10289334")
    }
    
    func testPart2TestData() throws {
        let challenge = Day11(data: part2TestData)
        let result = challenge.part2(repeating: 10)
        XCTAssertEqual(String(describing: result), "1030")
    }
    
    func testPart2() throws {
        let challenge = Day11()
        let result = challenge.part2(repeating: 1000000)
        XCTAssertEqual(String(describing: result), "649862989626")
    }
}
