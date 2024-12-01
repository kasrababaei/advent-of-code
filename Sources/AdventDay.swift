@_exported import Algorithms
@_exported import Collections
import Foundation

protocol AdventDay: Sendable {
  /// The year of the Advent of Code challenge.
  ///
  /// Prefix the year with the letter Y, for example: `Y2020Day01.swift`
  static var year: Int { get }
  
  /// The day of the Advent of Code challenge.
  ///
  /// You can implement this property, or, if your type is named with the
  /// day number as its suffix (like `Day01`), it is derived automatically.
  static var day: Int { get }
  
  /// An initializer that uses the provided test data.
  init(data: String)
  
  /// Computes and returns the answer for part one.
  func part1() async throws -> Any
  
  /// Computes and returns the answer for part two.
  func part2() async throws -> Any
}

extension AdventDay {
  // Find the challenge year from the type name.
  static var year: Int {
    let typeName = String(reflecting: Self.self)
    guard let yearMatch = typeName.firstMatch(of: /.*Y(\d{4})Day/)?.output.1,
          let year = Int(yearMatch)
    else {
      fatalError(
        """
        Year number not found in type name: \
        implement the static `year` property \
        or use the year number as your type's suffix (like `Y2020Day3`).")
        """)
    }
    return year
  }
  
  var year: Int {
    Self.year
  }
  
  
  // Find the challenge day from the type name.
  static var day: Int {
    let typeName = String(reflecting: Self.self)
    guard let dayIndex = typeName.lastIndex(where: { !$0.isNumber }),
          let day = Int(typeName[dayIndex...].dropFirst())
    else {
      fatalError(
        """
        Day number not found in type name: \
        implement the static `day` property \
        or use the day number as your type's suffix (like `Day3`).")
        """)
    }
    return day
  }
  
  var day: Int {
    Self.day
  }
  
  // Default implementation of `part2`, so there aren't interruptions before
  // working on `part1()`.
  func part2() -> Any {
    "Not implemented yet"
  }
  
  /// An initializer that loads the test data from the corresponding data file.
  init() {
    self.init(data: Self.loadData(challengeYear: Self.year, day: Self.day))
  }
  
  static func loadData(challengeYear year: Int, day: Int) -> String {
    let dayString = String(format: "%02d", day)
    let dataFilename = "Y\(year)Day\(dayString)"
    let dataURL = Bundle.module.url(
      forResource: dataFilename,
      withExtension: "txt",
      subdirectory: "Data/\(year)")
    
    guard let dataURL,
          let data = try? String(contentsOf: dataURL, encoding: .utf8)
    else {
      fatalError("Couldn't find file '\(dataFilename).txt' in the 'Data' directory.")
    }
    
    // On Windows, line separators may be CRLF. Converting to LF so that \n
    // works for string parsing.
    return data.replacingOccurrences(of: "\r", with: "")
  }
}
