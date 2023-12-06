import XCTest
@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    let testData = """
    Time:      7  15   30
    Distance:  9  40  200
    
    """
    
    func testPart1() throws {
        var challenge = Day06(data: testData)
        var result = challenge.part1()
        XCTAssertEqual(String(describing: result), "288")
        
        challenge = Day06()
        result = challenge.part1()
        XCTAssertEqual(String(describing: result), "771628")
    }
    
    func testPart2() throws {
        var challenge = Day06(data: testData)
        var result = challenge.part2()
        XCTAssertEqual(String(describing: result), "71503")
        
        challenge = Day06()
        result = challenge.part2()
        XCTAssertEqual(String(describing: result), "27363861")
    }
}
