struct Day06: AdventDay {
    var data: String
    
    // Non-capturing group zero or more words followed by a a colon,
    // proceeds with zero or more spaces,
    // captures one or more digits
    let regex = /(?:\w*:)?\s*(\d+)/
    
    func part1() -> Any {
        let lines = data.components(separatedBy: .newlines)
        let times = lines[0].matches(of: regex).map { try! "\($0.output.1)".toInteger() }
        let distances = lines[1].matches(of: regex).map { try! "\($0.output.1)".toInteger() }
        
        return zip(times, distances)
            .map { duration, distance in
                (0...duration)
                    .dropFirst()
                    .dropLast()
                    .filter { ($0...duration).delta * $0 > distance }.count
            }
            .reduce(1, *)
    }
    
    func part2() -> Any {
        let lines = data.components(separatedBy: .newlines)
        let maxTime = try! lines[0].matches(of: regex).map { "\($0.output.1)" }.joined().toInteger()
        let distance = try! lines[1].matches(of: regex).map { "\($0.output.1)" }.joined().toInteger()
        let range = (0...maxTime)
        
        let minFirstIndex = range
            .dropFirst()
            .dropLast()
            .firstIndex(where: { ($0...maxTime).delta * $0 > distance })!
        
        let maxFistIndex = range
            .dropFirst()
            .dropLast()
            .reversed()
            .firstIndex(where: { ($0...maxTime).delta * $0 > distance })!
        
        return range[maxFistIndex.base] - range[minFirstIndex]
    }
}
