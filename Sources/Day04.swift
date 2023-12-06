import Foundation

struct Day04: AdventDay {
    let shouldLog = false
    
    var data: String
    
    func part1() -> Any {
        cards(lines: data.components(separatedBy: .newlines))
            .reduce(into: 0) { $0 += $1.point }
    }
    
    func part2() -> Any {
        var sum = 0
        let cards = cards(lines: data.components(separatedBy: .newlines))
        var dict: [Int: [Card]] = Dictionary(grouping: cards) { $0.id }
        
        for index in cards.indices {
            for card in dict[index + 1]! {
                cards[(card.id..<card.id + card.matchedNumbers.count)]
                    .forEach { dict[$0.id, default: []].append($0) }
            }
            sum += dict[index + 1]?.count ?? 0
        }
        
        return sum
    }
    
    private func cards(lines: [String]) -> [Card] {
        lines
            .compactMap { line -> Card? in
                guard !line.isEmpty else {
                    return nil
                }
                
                let id = try! line.firstMatch(of: /^Card\s+(\d+):/)!.1.toInteger()
                let numbers = line.drop(while: { $0 != ":" }).components(separatedBy: "|")
                let winningNumbers = numbers
                    .first!
                    .components(separatedBy: .whitespaces)
                    .compactMap { try? $0.toInteger() }
                
                let collectedNumbers = numbers.last!
                    .components(separatedBy: .whitespaces)
                    .compactMap { try? $0.toInteger() }
                
                return Card(
                    id: id,
                    winningNumbers: Set(winningNumbers),
                    collectedNumbers: Set(collectedNumbers)
                )
            }
    }
}

struct Card: Hashable {
    var id: Int = -1
    var winningNumbers: Set<Int> = []
    var collectedNumbers: Set<Int> = []
    var matchedNumbers: Set<Int> {
        winningNumbers.intersection(collectedNumbers)
    }
    var point: Int {
        matchedNumbers
            .enumerated()
            .reduce(into: 0) { partialResult, value in
                if value.offset == 0 {
                    partialResult += 1
                } else {
                    partialResult *= 2
                }
            }
    }
}
