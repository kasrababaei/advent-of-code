import XCTest
@testable import AdventOfCode

final class Day05Tests: XCTestCase {
    let testData = """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    
    """
    
    func testPart1() async throws {
        var challenge = Day05(data: testData)
        var result = try await challenge.part1()
        XCTAssertEqual(String(describing: result), "35")
        
        challenge = Day05()
        result = try await challenge.part1()
        XCTAssertEqual(String(describing: result), "836040384")
    }
    
    func testPart2() async throws {
        var challenge = Day05(data: testData)
        var result = try await challenge.part2()
        XCTAssertEqual(String(describing: result), "46")
        
        challenge = Day05()
        result = try await challenge.part2()
        XCTAssertEqual(String(describing: result), "0")
    }
}
