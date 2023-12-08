struct Day08: AdventDay {
    var data: String
    
    let regex = /(\w*) = \((\w*), (\w*)/
    
    func part1() -> Any {
        let lines = data.components(separatedBy: .newlines)
        let instructions = Array(lines[0])
        
        let dict: [String: Node] = lines
            .dropFirst(2)
            .compactMap { line in
                line.matches(of: regex).compactMap(Node.init).first
            }
            .reduce(into: [:]) { $0[$1.name] = $1 }
        
        return travel(from: "AAA", to: { $0 == "ZZZ" }, in: dict, with: instructions)
    }
    
    func part2() -> Any {
        let lines = data.components(separatedBy: .newlines)
        let instructions = Array(lines[0])
        
        let dict: [String: Node] = lines
            .dropFirst(2)
            .compactMap { line in
                line.matches(of: regex).compactMap(Node.init).first
            }
            .reduce(into: [:]) { $0[$1.name] = $1 }
        
        let nodes = dict.values.filter { $0.name.hasSuffix("A") }
        let lengths = nodes.map {
            travel(from: $0.name, to: { $0.hasSuffix("Z") }, in: dict, with: instructions)
        }
        
        return lengths.reduce(into: 1) {
            $0 = lcm($0, $1)
        }
    }
    
    private func travel(
        from source: String,
        to destination: (String) -> Bool,
        in dict: [String: Node],
        with instructions: [Character]
    ) -> Int {
        var node = dict[source]!
        var index = 0
        var steps = 0
        
        while !destination(node.name) {
            let instruction = instructions[index]
            index = index == instructions.count - 1 ? 0 : index + 1
            
            if instruction == "L" {
                node = dict[node.left]!
            } else {
                node = dict[node.right]!
            }
            
            steps += 1
        }
        
        return steps
    }
}

private struct Node: Equatable {
    let name: String
    let left: String
    let right: String
    
    init(_ match: Regex<Regex<(Substring, Substring, Substring, Substring)>.RegexOutput>.Match) {
        self.name = String(match.output.1)
        self.left = String(match.output.2)
        self.right = String(match.output.3)
    }
}

private func gcd(_ m: Int, _ n: Int) -> Int {
    let r = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

private func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}
