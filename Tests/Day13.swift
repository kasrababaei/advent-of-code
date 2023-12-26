import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase {
    let testData = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """
    
    var part2TestData: String { testData }
    
    func testPart1TestData() throws {
        let challenge = Day13(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "405")
    }
    
    func testPart1() throws {
        let challenge = Day13()
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "33520")
    }
    
    func testPart2TestData() throws {
        let challenge = Day13(data: part2TestData)
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "400")
    }
    
    func testPart2() throws {
        let challenge = Day13()
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "34824")
    }
}
