import XCTest
@testable import AdventOfCode

final class Y2023Day03Tests: XCTestCase {
    let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    
    """
    
    func testPart1() throws {
        var challenge = Y2023Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "4361")
        
        challenge = Y2023Day03()
         XCTAssertEqual(String(describing: challenge.part1()), "531932")
    }
    
    func testPart2() throws {
        var challenge = Y2023Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "467835")
        
        challenge = Y2023Day03()
        XCTAssertEqual(String(describing: challenge.part2()), "73646890")
    }
}
