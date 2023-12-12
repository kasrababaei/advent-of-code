import XCTest
@testable import AdventOfCode

final class Day09Tests: XCTestCase {
    let testData = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """
    
    var part2TestData: String { testData }
    
    func testPart1TestData() throws {
        let challenge = Day09(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "114")
    }
    
    func testPart1() throws {
        let challenge = Day09()
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "1980437560")
    }
    
    func testPart2TestData() throws {
        let challenge = Day09(data: part2TestData)
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "2")
    }
    
    func testPart2() throws {
        let challenge = Day09()
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "977")
    }
}
