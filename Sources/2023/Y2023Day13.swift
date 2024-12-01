struct Y2023Day13: AdventDay {
    var data: String
    
    func part1() -> Any {
        searchReflections(isSmudged: false)
    }
    
    func part2() -> Any {
        searchReflections(isSmudged: true)
    }
    
    private func searchReflections(isSmudged: Bool) -> Int {
        data
            .components(separatedBy: .newlines)
            .split(whereSeparator: { $0.isEmpty })
            .map { Pattern(Array($0)) }
            .compactMap {
                let horizontal = searchReflections(in: $0.rows, isSmudged: isSmudged)
                
                if horizontal > 0 {
                    return horizontal * 100
                } else {
                    return searchReflections(in: $0.columns, isSmudged: isSmudged)
                }
            }
            .sum
    }
    
    private func searchReflections(in array: [String], isSmudged: Bool) -> Int {
        for index in 1..<array.count {
            var top = array[0..<index]
            var bottom = array[index...]
            if bottom.count > top.count {
                bottom = bottom.prefix(top.count)
            } else if bottom.count < top.count {
                top = top.suffix(bottom.count)
            }
            
            if isSmudged {
                let diff = zip(Array(top), Array(bottom.reversed()))
                    .reduce(into: 0) { result, zipped in
                        let lhs = zipped.0.map { $0 }
                        let rhs = zipped.1.map { $0 }
                        let diff = zip(lhs, rhs).reduce(into: 0) { $0 += $1.0 == $1.1 ? 0 : 1 }
                        
                        result += diff
                    }
                
                
                if diff == 1 {
                    return index
                }
            } else if Array(top) == Array(bottom.reversed()) {
                return index
            }
        }
        
        return 0
    }
}

struct Pattern {
    let rows: [String]
    let columns: [String]
    
    init(_ rows: [String]) {
        self.rows = rows
        self.columns = (0..<rows[0].count)
            .map { index in
                rows
                    .map { $0.charAt(index) }
                    .reduce(into: "") { $0.append($1) }
            }
    }
}
