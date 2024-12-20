import ArgumentParser
import Foundation

let years: [[any AdventDay]] = [
  year1970,
  year2023,
  year2024
]

// Add each new day implementation to this array:
let allChallenges: [any AdventDay] = years.flatMap(\.self)

let year1970: [any AdventDay] = [Y1970Day01()]

let year2023: [any AdventDay] = [
  Y2023Day01(),
  Y2023Day02(),
  Y2023Day03(),
  Y2023Day04(),
  Y2023Day05(),
  Y2023Day06(),
  Y2023Day07(),
  Y2023Day08(),
  Y2023Day09(),
  Y2023Day11(),
  Y2023Day12(),
  Y2023Day13()
]

let  year2024: [any AdventDay] = [
  Y2024Day01(),
  Y2024Day02(),
  Y2024Day03(),
  Y2024Day04(),
  Y2024Day05(),
  Y2024Day06(),
  Y2024Day07(),
  Y2024Day08(),
  Y2024Day09(),
  Y2024Day10(),
]

@main
struct AdventOfCode: AsyncParsableCommand {
  public static var configuration: CommandConfiguration {
    CommandConfiguration(
      commandName: "advent-of-code",
      abstract: "Runs Advent of Code challenges"
    )
  }
  
  @Argument(help: "The year of the challenge. For 2020, use '2020'.")
  var year: Int?
  
  @Argument(help: "The day of the challenge. For December 1st, use '1'.")
  var day: Int?
  
  @Flag(help: "Benchmark the time taken by the solution")
  var benchmark: Bool = false
  
  /// The selected day, or the latest day if no selection is provided.
  var selectedChallenge: any AdventDay {
    get throws {
      if let year, let day {
        guard let year = years.first(where: { $0.first?.year == year }) else {
          throw ValidationError("No solution found for year \(year)")
        }
        
        if let challenge = year.first(where: { $0.day == day }) {
          return challenge
        } else {
          throw ValidationError("No solution found for day \(day)")
        }
      } else {
        print("Running last challenge...")
        return latestChallenge
      }
    }
  }
  
  /// The latest challenge in `allChallenges`.
  var latestChallenge: any AdventDay {
    years.last!.max(by: { $0.day < $1.day })!
  }
  
  private var style = Duration.UnitsFormatStyle(
    allowedUnits: [
      .seconds,
      .milliseconds,
      .microseconds
    ],
    width: .condensedAbbreviated,
    maximumUnitCount: 3,
    valueLength: 3
  )
  
  func run(part: () async throws -> Any, named: String, shouldLog: Bool) async -> Duration {
    var result: Result<Any, Error> = .success("<unsolved>")
    
    let timing = await ContinuousClock().measure {
      do {
        result = .success(try await part())
      } catch {
        result = .failure(error)
      }
    }
    
    let named = named.leftPadded()
    
    switch result {
    case .success(let success):
      if shouldLog {
        print("Part \(named): \(success)")
      }
    case .failure(let failure):
      print("\(named): Failed with error: \(failure)")
    }
    
    return timing
  }
  
  func run() async throws {
    let challenge = try selectedChallenge
    
    print("Executing Advent of Code challenge year \(challenge.year) day \(challenge.day)...")
    
    var partOneDurations: [Duration] = []
    var partTwoDurations: [Duration] = []
    
    let runs = benchmark ? 10 : 1
    
    for index in 0...runs {
      let partOneDuration = await run(
        part: challenge.part1,
        named: "1",
        shouldLog: index == 0
      )
      partOneDurations.append(partOneDuration)
      
      let partTwoDuration = await run(
        part: challenge.part2,
        named: "2",
        shouldLog: index == 0
      )
      partTwoDurations.append(partTwoDuration)
    }
    
    logBenchmark(durations: partOneDurations, for: 1)
    logBenchmark(durations: partTwoDurations, for: 2)
  }
  
  func logBenchmark(durations: [Duration], for part: Int) {
    guard let min = durations.min()?.formatted(style).padded(),
          let max = durations.max()?.formatted(style).padded()
    else {
      fatalError("Cannot compute min/max.")
    }
    
    let sum = durations.reduce(into: Duration.zero) { $0 += $1 }
    let average = (sum / durations.count).formatted(style).padded()
    let part = "\(part)".leftPadded()
    
    print("Part \(part) results: | min: \(min) | max: \(max) | average: \(average)")
  }
}
