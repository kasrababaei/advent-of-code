struct Day05: AdventDay {
    var data: String
    
    var seeds: [Int] {
        data.prefix(while: { $0 != "\n" })
            .matches(of: /(?:seeds:)? (\d+).*?/)
            .compactMap { try? "\($0.1)".toInteger() }
    }
    
  var regex: Regex<(Substring, Substring, Substring, Substring)> { /(\d+) (\d+) (\d+)/ }
    
    func part1() async throws -> Any {
        let lines = data.components(separatedBy: .newlines)
        let seeds = lines.first.map(seeds(inLine:))!
        let ranges: [ClosedRange<Int>] = seeds.map { ($0...$0) }
        
        var maps: [[(from: ClosedRange<Int>, to: ClosedRange<Int>)]] = Array(repeating: [], count: 7)
        
        var index = 0
        
        for line in lines.dropFirst(3) {
            guard !line.isEmpty else {
                continue
            }
            
            guard !line.hasSuffix("map:") else {
                index += 1
                continue
            }
            
            let numbers = line.matches(of: regex).first!
            
            let from = try! numbers.1.toInteger()
            let to = try! numbers.2.toInteger()
            let length = try! numbers.3.toInteger() - 1
            
            maps[index].append(
                (from...(from + length), to...(to + length))
            )
        }
        
        return try await ranges
            .concurrentMap { [maps] range in
                await minimumLocation(range: range, maps: maps)
            }
            .min() ?? Int.max
    }
    
    func part2() async throws -> Any {
        let lines = data.components(separatedBy: .newlines)
        let seeds = lines.first.map(seeds(inLine:))!
        var ranges: [ClosedRange<Int>] = []
        
        for (index, seed) in seeds.striding(by: 2).enumerated() {
            let length = seeds[index * 2 + 1] - 1
            let upperBound = seed + length
            ranges.append(seed...upperBound)
        }
        
        var maps: [[(from: ClosedRange<Int>, to: ClosedRange<Int>)]] = Array(repeating: [], count: 7)
        
        var index = 0
        
        for line in lines.dropFirst(3) {
            guard !line.isEmpty else {
                continue
            }
            
            guard !line.hasSuffix("map:") else {
                index += 1
                continue
            }
            
            let numbers = line.matches(of: regex).first!
            
            let from = try! numbers.1.toInteger()
            let to = try! numbers.2.toInteger()
            let length = try! numbers.3.toInteger() - 1
            
            maps[index].append(
                (from...(from + length), to...(to + length))
            )
        }
        
        return try await ranges
            .concurrentMap { [maps] range in
                await minimumLocation(range: range, maps: maps)
            }
            .min() ?? Int.max
    }
    
    func seeds(inLine line: String) -> [Int] {
        line
            .matches(of: /(?:seeds:)? (\d+).*?/)
            .compactMap { try? "\($0.1)".toInteger() }
    }
    
    func minimumLocation(
        range: ClosedRange<Int>,
        maps: [[(from: ClosedRange<Int>, to: ClosedRange<Int>)]]
    ) async -> Int {
        var location = Int.max
        
        for seed in range {
            var mappedValue = seed
            
            for map in maps {
                if let tuple = map.first(where: { $0.to.contains(mappedValue) }) {
                    mappedValue = tuple.from.lowerBound + mappedValue - tuple.to.lowerBound
                }
            }
            
            location = min(mappedValue, location)
        }
        
        return location
    }
}
