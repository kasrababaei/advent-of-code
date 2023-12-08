import XCTest
@testable import AdventOfCode

final class Day08Tests: XCTestCase {
    let testData = """
    LLR
    
    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let part2TestData = """
    LR
    
    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    
    func testPart1TestData() throws {
        let challenge = Day08(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "6")
    }
    
    func testPart1() throws {
        let challenge = Day08()
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "22199")
    }
    
    func testPart2TestData() throws {
        let challenge = Day08(data: part2TestData)
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "6")
    }
    
    func testPart2() throws {
        let challenge = Day08()
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "13334102464297")
    }
}
