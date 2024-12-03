import XCTest

@testable import AdventOfCode

// One off test to validate that basic data load testing works
final class Y1970Day01Tests: XCTestCase {
  let testData = """
      1000
      2000
      3000
      
      4000
      
      5000
      6000
      
      7000
      8000
      9000
      
      10000
      
      """
  
  func testInitData() throws {
    let challenge = Y1970Day01()
    XCTAssertTrue(challenge.data.starts(with: "4514"))
  }
  
  func testPart1() throws {
    let challenge = Y1970Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6000")
  }
  
  func testPart2() throws {
    let challenge = Y1970Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "32000")
  }
}
