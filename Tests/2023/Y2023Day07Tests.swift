import XCTest
@testable import AdventOfCode

final class Y2023Day07Tests: XCTestCase {
    let testData = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    
    """
    
    func testPart1TestData() throws {
        let challenge = Y2023Day07(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "6440")
    }
    
    func testPart1() throws {
        let challenge = Y2023Day07()
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "249483956")
    }
    
    func testPart2TestData() throws {
        let challenge = Y2023Day07(data: testData)
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "5905")
    }
    
    func testPart2() throws {
        let challenge = Y2023Day07()
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "252137472")
    }
}
