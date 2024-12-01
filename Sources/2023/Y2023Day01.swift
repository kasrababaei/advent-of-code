import Foundation

struct Y2023Day01: AdventDay {
    var data: String
    
    func part1() -> Any {
        var numbers: [Int] = []
        
        for line in data.components(separatedBy: .newlines) {
            guard !line.isEmpty else { continue }
            
            guard let firstNumber = line.first(where: \.isNumber),
                  let lastNumber = line.reversed().first(where: \.isNumber),
                  let number = try? 10 * firstNumber.toInteger() + lastNumber.toInteger()
            else { fatalError() }
            
            numbers.append(number)
        }
        
        return numbers.reduce(into: 0) { $0 += $1 }
    }
    
    func part2() -> Any {
        let spelledOutNumbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        let reversedSpelledOutNumbers = spelledOutNumbers.map { String($0.reversed()) }
        
        var numbers: [Int] = []
        
        for line in data.components(separatedBy: .newlines) {
            guard !line.isEmpty else { continue }
            
            let firstNumber = self.firstNumber(in: line, spelledOutNumbers: spelledOutNumbers)
            let lastNumber = self.firstNumber(in: String(line.reversed()), spelledOutNumbers: reversedSpelledOutNumbers)
            let number = 10 * firstNumber + lastNumber
            
            numbers.append(number)
        }
        
        return numbers.reduce(into: 0) { $0 += $1 }
    }
    
    private func firstNumber(in line: String, spelledOutNumbers: [String]) -> Int {
        var number = 0
        
        for (index, char) in line.enumerated() {
            if let value = try? char.toInteger() {
                number = value
                break
            }
            
            let subSequence = line.dropFirst(index)
            
            if let index = spelledOutNumbers.firstIndex(where: { subSequence.hasPrefix($0) }) {
                number = index + 1
                break
            }
        }
        
        return number
    }
}
