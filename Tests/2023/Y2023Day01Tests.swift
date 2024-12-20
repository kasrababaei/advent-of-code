import XCTest
@testable import AdventOfCode

final class Y2023Day01Tests: XCTestCase {
    let partOneTestData = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    
    """
    
    let partTwoTestDate = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    
    func testPart1() throws {
        let challenge = Y2023Day01(data: partOneTestData)
        XCTAssertEqual(String(describing: challenge.part1()), "142")
    }
    
    func testPart2() throws {
        let challenge = Y2023Day01(data: partTwoTestDate)
        XCTAssertEqual(String(describing: challenge.part2()), "281")
    }
}
