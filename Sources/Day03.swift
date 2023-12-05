import Foundation

struct Day03: AdventDay {
    var data: String
    
    func part1() -> Any {
        let lines = data.components(separatedBy: .newlines).dropLast()
        
        let rows = lines.count
        let columns = lines.first?.count ?? 0
        
        var matrix: [[Character]] = Array(repeating: .init(repeating: " ", count: columns), count: rows)
        
        for (index, character) in data.replacingOccurrences(of: "\n", with: "").enumerated() {
            let row = index / columns
            let column = index % columns
            matrix[row][column] = character
        }
        
        var numbersAdjacentToSymbols: [Parts] = []
        
        for (row, line) in lines.enumerated() {
            var hasAdjacentSymbol = false
            var numbers: [Character] = []
            var parts = Parts(line: row + 1)
            
            for (column, character) in line.enumerated() {
                if character.isNumber {
                    if !hasAdjacentSymbol {
                        // Check for adjacent symbols
                        hasAdjacentSymbol = matrix.hasAdjacentSymbol(row: row, column: column)
                    }
                    
                    // Store the number
                    numbers.append(character)
                }
                
                if !character.isNumber || column == columns - 1 {
                    guard let value = try? numbers.reduce(into: "", { $0 = $0 + "\($1)" }).int else {
                        continue
                    }
                    
                    let part = Part(value: value, point: .init(row: row, column: column))
                    
                    if hasAdjacentSymbol {
                        // It's not a number, but previously we had a number with an adjacent symbol
                        parts.includedParts.append(part)
                    } else {
                        parts.excludedParts.append(part)
                    }
                    
                    // Reset
                    hasAdjacentSymbol = false
                    numbers = []
                }
            }
            
            numbersAdjacentToSymbols.append(parts)
        }
        
        return numbersAdjacentToSymbols.reduce(0) { $0 + $1.sum }
    }
    
    func part2() -> Any {
        let lines = data.components(separatedBy: .newlines).dropLast()
        let rows = lines.count
        let columns = lines.first?.count ?? 0
        
        var matrix: [[Character]] = Array(repeating: .init(repeating: " ", count: columns), count: rows)
        
        for (index, character) in data.replacingOccurrences(of: "\n", with: "").enumerated() {
            let row = index / columns
            let column = index % columns
            matrix[row][column] = character
        }
        
        var gears: Set<Pair> = []
        
        for (row, line) in lines.enumerated() {
            for (column, character) in line.enumerated() {
                guard character == "*" else {
                    continue
                }
                
                let numericalNeighbours = matrix.numericalNeighbours(row: row, column: column)
                
                if numericalNeighbours.count == 2 {
                    let numericalNeighbours = numericalNeighbours.map { $0 }
                    
                    let first = numericalNeighbours[0]
                    let second = numericalNeighbours[1]
                    gears.insert(.init(first: first, second: second))
                }
            }
        }
        
        var sum = 0
        
        for gear in gears {
            sum += gear.first * gear.second
        }
        
        return sum
    }
}

struct Pair: Hashable {
    let first: Int
    let second: Int
}

extension Array {
    subscript(safe index: Int) -> Element? {
        if indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }
}

extension Array where Element == [Character] {
    func neighbours(row: Int, column: Int) -> [Character] {
        [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            .compactMap { (rowOffset, columnOffset) in
                self[safe: row + rowOffset]?[safe: column + columnOffset]
            }
    }
    
    func hasAdjacentSymbol(row: Int, column: Int) -> Bool {
        [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            .lazy
            .contains { (rowOffset, columnOffset) in
                self[safe: row + rowOffset]?[safe: column + columnOffset]?.isCustomSymbol == true
            }
    }
    
    func firstAdjacentNumber(row: Int, column: Int) -> Int? {
        [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            .lazy
            .compactMap { (rowOffset, columnOffset) in
                try? self[safe: row + rowOffset]?[safe: column + columnOffset]?.int
            }
            .first
    }
    
    func numericalNeighbours(row: Int, column: Int) -> Set<Int> {
        let number: (Int, Int) -> Int = { row, column in
            var number = ""
            
            var start = 0
            
            var index = column
            while (try? self[safe: row]?[safe: index]?.int) != nil {
                start = index
                index -= 1
            }
            
            index = start
            while let value = try? self[safe: row]?[safe: index]?.int {
                number = "\(number)\(value)"
                index += 1
            }
            
            return try! number.int
        }
        // Look up
        let up = [(-1, -1), (-1, 0), (-1, 1)]
            .filter { (rowOffset, columnOffset) in
                (try? self[safe: row + rowOffset]?[safe: column + columnOffset]?.int) != nil
            }
            .map {
                number(row - 1, column + $1)
            }
            
        
        // Look sideways
        let sideways = [(0, -1), (0, 1)]
            .filter { (_, columnOffset) in
                (try? self[safe: row]?[safe: column + columnOffset]?.int) != nil
            }
            .map {
                number(row, column + $1)
            }
        
        // Look bottom
        let bottom = [(1, -1), (1, 0), (1, 1)]
            .filter { (rowOffset, columnOffset) in
                (try? self[safe: row + rowOffset]?[safe: column + columnOffset]?.int) != nil
            }
            .map {
                number(row + 1, column + $1)
            }
        
        return Set([up + sideways + bottom].flatMap { $0 })
    }
    
    func numberByTraversingAt(row: Int, column: Int) -> Int {
        var partialLine = ""
        
        for i in (column - 3)...(column + 3) {
            if let c = self[row][safe: i] {
                partialLine += "\(c)"
            }
        }
        
        var number = ""
        
        var start = 0
        
        var index = column
        while (try? self[row][safe: index]?.int) != nil {
            start = index
            index -= 1
        }
        
        index = start
        while let value = try? self[row][safe: index]?.int {
            number = "\(number)\(value)"
            index += 1
        }
        
        return try! number.int
    }
}

extension Character {
    var isCustomSymbol: Bool {
        !isNumber && self != "."
    }
}

struct Parts {
    let line: Int
    var includedParts: [Part] = []
    var excludedParts: [Part] = []
    
    var sum: Int {
        includedParts.reduce(0) { $0 + $1.value}
    }
    
    var excludedDescription: String {
        "Line \(line)) Exc. \(excludedParts)"
    }
    
    var description: String {
        "Line \(line)) Inc. \(includedParts) | Exc. \(excludedParts)"
    }
}

struct Part: Hashable {
    let value: Int
    let point: Point
    var neighbours: Set<Neighbour> = []
}

struct Point: Hashable, Comparable {
    static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        } else {
            return lhs.row < rhs.row
        }
    }
    
    let row: Int
    let column: Int
}

struct Neighbour: Hashable {
    let value: String
    var isGear: Bool { value == "*" }
    var int: Int? { try? value.int }
    let points: Point
}
