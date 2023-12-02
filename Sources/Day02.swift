import Foundation

struct Day02: AdventDay {
    var data: String
    
    func part1() -> Any {
        data
            .components(separatedBy: "\n")
            .compactMap { Game(line: $0, shouldApplyLimit: true)?.id }
            .reduce(into: 0) { $0 += $1 }
    }
    
    func part2() -> Any {
        data
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .compactMap { Game(line: $0, shouldApplyLimit: false)?.power }
            .reduce(into: 0) { $0 += $1 }
    }
}

struct Game {
    let id: Int
    let maxBlue: Int
    let maxRed: Int
    let maxGreen: Int
    
    var power: Int {
        maxBlue * maxRed * maxGreen
    }
    
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
        
        for bag in subsets.components(separatedBy: .init([";"])) {
            for cube in bag.components(separatedBy: ",") {
                if cube.hasSuffix("blue") {
                    let value = cube
                        .trimmingCharacters(in: .whitespaces)
                        .prefix(while: \.isWholeNumber)
                    
                    guard let value = Int(value) else {
                        return nil
                    }
                    
                    if shouldApplyLimit, value > 14 {
                        return nil
                    }
                    
                    if value > maxBlue {
                        maxBlue = value
                    }
                } else if cube.hasSuffix("red") {
                    let value = cube
                        .trimmingCharacters(in: .whitespaces)
                        .prefix(while: \.isWholeNumber)
                    
                    guard let value = Int(value) else {
                        return nil
                    }
                    
                    if shouldApplyLimit, value > 12 {
                        return nil
                    }
                    
                    if value > maxRed {
                        maxRed = value
                    }
                } else if cube.hasSuffix("green") {
                    let value = cube
                        .trimmingCharacters(in: .whitespaces)
                        .prefix(while: \.isWholeNumber)
                    
                    guard let value = Int(value) else {
                        return nil
                    }
                    
                    if shouldApplyLimit, value > 13 {
                        return nil
                    }
                    
                    if value > maxGreen {
                        maxGreen = value
                    }
                }
            }
            
        }
        
        guard let id = gameId
            .firstIndex(where: \.isWholeNumber)
            .flatMap ({ Int("\(gameId[$0...])") })
        else {
            return nil
        }
        
        self.id = id
        self.maxBlue = maxBlue
        self.maxRed = maxRed
        self.maxGreen = maxGreen
    }
}
