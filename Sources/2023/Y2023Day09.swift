struct Y2023Day09: AdventDay {
    var data: String
    
  var regex: Regex<(Substring, Substring)> { /(-?\d+)/ }
    var lines: [[Int]] {
        get {
            data
                .components(separatedBy: .newlines)
                .compactMap { line in
                    line.matches(of: regex).map { try! $0.output.1.toInteger() }
                }
        }
    }
    
    func part1() -> Any {
        lines
            .map { line in
                var diffSequence = [line]
                var containsNonZeros = true
                
                while containsNonZeros {
                    let diff = zip(diffSequence.last!, diffSequence.last!.dropFirst()).map { $1 - $0 }
                    diffSequence.append(diff)
                    
                    containsNonZeros = diff.contains(where: { $0 != 0 })
                }
                
                return diffSequence
                    .compactMap { $0.last }.sum
            }
            .sum
    }
    
    func part2() -> Any {
        lines
            .map { line in
                var diffSequence = [line]
                var containsNonZeros = true
                
                while containsNonZeros {
                    let diff = zip(diffSequence.last!, diffSequence.last!.dropFirst()).map { $1 - $0 }
                    diffSequence.append(diff)
                    
                    containsNonZeros = diff.contains(where: { $0 != 0 })
                }
                
                return diffSequence
                    .compactMap { $0.first }
                    .reversed()
                    .dropFirst()
                    .reduce(into: 0) { $0 = $1 - $0 }
            }
            .sum
    }
}
