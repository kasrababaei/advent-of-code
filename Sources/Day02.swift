import Foundation

struct Day02: AdventDay {
    var data: String
    
    func part1() -> Any {
        data
            .components(separatedBy: .newlines)
            .compactMap { Game(line: $0, shouldApplyLimit: true)?.id }
            .reduce(into: 0) { $0 += $1 }
    }
    
    func part2() -> Any {
        data
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .compactMap { Game(line: $0, shouldApplyLimit: false)?.power }
            .reduce(into: 0) { $0 += $1 }
    }
}

struct Game {
    let id: Int
    let power: Int
    
    init?(line: String, shouldApplyLimit: Bool) {
        guard !line.isEmpty else { return nil }
        
        let components = line.components(separatedBy: ":")
        
        guard let gameId = components.first,
              let subsets = components.last
        else {
            fatalError()
        }
        
        var maxBlue = 0
        var maxRed = 0
        var maxGreen = 0
        
        let numberOfCubes: (String) -> Int = { cube in
            try! cube
                .trimmingCharacters(in: .whitespaces)
                .prefix(while: \.isNumber)
                .int
        }
        
        for bag in subsets.components(separatedBy: ";") {
            for cube in bag.components(separatedBy: ",") {
                if cube.hasSuffix("blue") {
                    let value = numberOfCubes(cube)
                    
                    if shouldApplyLimit, value > 14 {
                        return nil
                    }
                    
                    maxBlue = max(maxBlue, value)
                } else if cube.hasSuffix("red") {
                    let value = numberOfCubes(cube)
                    
                    if shouldApplyLimit, value > 12 {
                        return nil
                    }
                    
                    maxRed = max(maxRed, value)
                } else if cube.hasSuffix("green") {
                    let value = numberOfCubes(cube)
                    
                    if shouldApplyLimit, value > 13 {
                        return nil
                    }
                    
                    maxGreen = max(maxGreen, value)
                }
            }
            
        }
        
        self.id = try! gameId.firstMatch(of: /^Game (\d+)/)!.1.int
        self.power = maxBlue * maxRed * maxGreen
    }
}
