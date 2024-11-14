final class Day12: AdventDay {
  private var regex: Regex<(Substring, Substring)> { /\.?(\?*#*\?*#*)\.?/ }
    
    let data: String
    
    required init(data: String) {
        self.data = data
    }
    
    func part1() -> Any {
        lines()
            .map { arrangements($0) }
            .sum
    }
    
    func part2() -> Any {
        lines()
            .map { $0.unfolded }
            .map { arrangements($0) }
            .reduce(0, +)
    }
    
    private func lines() -> [Line] {
        data
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { newline in
                let components = newline.components(separatedBy: .whitespaces)
                
                return Line(
                    conditions: components[0],
                    sizes: components[1].components(separatedBy: ",").map { try! $0.toInteger() }
                )
            }
    }
    
    nonisolated(unsafe) private var cache = [Line: Int]()
    
    private func arrangements(_ line: Line) -> Int {
        if let cached = cache[line] {
            return cached
        } else {
            let value = _arrangements(line)
            cache[line] = value
            return value
        }
    }
    
    private func _arrangements(_ line: Line) -> Int {
        if line.sizes.isEmpty {
            return line.conditions.contains("#") ? 0 : 1
        }
        if line.conditions.isEmpty {
            return 0
        }
        
        let ch = line.conditions.first!
        let group = line.sizes.first!
        
        var sum = 0
        if ch == "#" {
            sum = pound(line, group)
        } else if ch == "." {
            sum = dot(line)
        } else if ch == "?" {
            sum = dot(line) + pound(line, group)
        }
        
        return sum
    }
    
    private func dot(_ line: Line) -> Int {
        arrangements(
            Line(
                conditions: String(line.conditions.dropFirst()),
                sizes: line.sizes
            )
        )
    }
    
    private func pound(_ line: Line, _ group: Int) -> Int {
        let thisGroup = line.conditions
            .prefix(group)
            .replacingOccurrences(of: "?", with: "#")
        
        if thisGroup != String(repeating: "#", count: group) {
            return 0
        }
        
        if line.conditions.count == group {
            return line.sizes.count == 1 ? 1 : 0
        }
        
        if "?.".contains(line.conditions.charAt(group)) {
            return arrangements(
                Line(
                    conditions: String(line.conditions.dropFirst(group + 1)),
                    sizes: Array(line.sizes.dropFirst())
                )
            )
        }
        return 0
    }
}

struct Line: Hashable {
    let conditions: String
    let sizes: [Int]
    
    var unfolded: Line {
        let conditions = [String](repeating: self.conditions, count: 5).joined(separator: "?")
        let sizes = [[Int]](repeating: self.sizes, count: 5).flatMap { $0 }
        return Line(conditions: conditions, sizes: sizes)
    }
}
