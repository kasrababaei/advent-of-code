import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase {
    let testData = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """
    
    var part2TestData: String { testData }
    
    func testPart1TestData() throws {
        let challenge = Day12(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "21")
    }
    
    func testPart1() throws {
        let challenge = Day12()
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "7344")
    }
    
    func testPart2TestData() throws {
        let challenge = Day12(data: part2TestData)
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "525152")
    }
    
    func testPart2() throws {
        let challenge = Day12()
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "1088006519007")
    }
}
