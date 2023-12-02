import ArgumentParser

// Add each new day implementation to this array:
let allChallenges: [any AdventDay] = [
    Day00(),
    Day01(),
    Day02()
]

@main
struct AdventOfCode: AsyncParsableCommand {
    @Argument(help: "The day of the challenge. For December 1st, use '1'.")
    var day: Int?
    
    @Flag(help: "Benchmark the time taken by the solution")
    var benchmark: Bool = false
    
    /// The selected day, or the latest day if no selection is provided.
    var selectedChallenge: any AdventDay {
        get throws {
            if let day {
                if let challenge = allChallenges.first(where: { $0.day == day }) {
                    return challenge
                } else {
                    throw ValidationError("No solution found for day \(day)")
                }
            } else {
                return latestChallenge
            }
        }
    }
    
    /// The latest challenge in `allChallenges`.
    var latestChallenge: any AdventDay {
        allChallenges.max(by: { $0.day < $1.day })!
    }
    
    private var style = Duration.UnitsFormatStyle(
        allowedUnits: [
            .seconds,
            .milliseconds,
            .microseconds
        ],
        width: .condensedAbbreviated
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
        
        switch result {
        case .success(let success):
            if shouldLog {
                print("\(named): \(success)")
            }
        case .failure(let failure):
            print("\(named): Failed with error: \(failure)")
        }
        
        return timing
    }
    
    func run() async throws {
        let challenge = try selectedChallenge
        
        print("Executing Advent of Code challenge \(challenge.day)...")
        
        var partOneDurations: [Duration] = []
        var partTwoDurations: [Duration] = []
        
        for index in 0...10 {
            let timing1 = await run(part: challenge.part1, named: "Part 1", shouldLog: index == 0)
            
            partOneDurations.append(timing1)
            
            let timing2 = await run(part: challenge.part2, named: "Part 2", shouldLog: index == 0)
            
            partTwoDurations.append(timing2)
        }
        
        if benchmark {
            logBenchmark(durations: partOneDurations, for: 1)
            logBenchmark(durations: partTwoDurations, for: 2)
        }
    }
    
    func logBenchmark(durations: [Duration], for part: Int) {
        #if DEBUG
        print("Looks like you're benchmarking debug code. Try swift run -c release")
        #endif
        
        
        guard let min = durations.min()?.formatted(style),
              let max = durations.max()?.formatted(style)
        else {
            fatalError("Cannot compute min/max.")
        }
        
        let sum = durations.reduce(into: Duration.zero) { $0 += $1 }
        let average = (sum / durations.count).formatted(style)
        
        print("Part \(part) results: min: \(min) | max: \(max) | average: \(average)")
    }
}
