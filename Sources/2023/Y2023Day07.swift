import Foundation

nonisolated(unsafe) private var shouldLog = false
nonisolated(unsafe) private var isWildCardEnabled = false

struct Y2023Day07: AdventDay {
    var data: String
    
  var regex: Regex<(Substring, Substring, Substring)> { /(.*) (\d+)/ }
    
    func part1() -> Any {
        let totalWinnings = data
            .components(separatedBy: .newlines).prefix(while: { !$0.isEmpty })
            .flatMap { line in
                line.matches(of: regex).map {
                    try! Hand(cards: $0.output.1, bid: $0.output.2)
                }
            }
            .sorted()
            .map {
                if shouldLog { print($0.cards, "\($0.bid)".padded(toLength: 3), $0.type, $0.cards.handStrength) }
                return $0
            }
            .map(\.bid)
            .enumerated()
        
        return totalWinnings.reduce(into: 0) { partialResult, tuple in
            partialResult += tuple.element * (tuple.offset + 1)
        }
    }
    
    func part2() -> Any {
        isWildCardEnabled = true
        
        let totalWinnings = data
            .components(separatedBy: .newlines).prefix(while: { !$0.isEmpty })
            .flatMap { line in
                line.matches(of: regex).map {
                    try! Hand(cards: $0.output.1, bid: $0.output.2)
                }
            }
            .sorted()
            .map {
                if shouldLog {
                    print($0.cards, $0.wildCard, "\($0.bid)".padded(toLength: 3), $0.type, $0.cards.handStrength)
                }
                return $0
            }
            .map(\.bid)
            .enumerated()
        
        return totalWinnings.reduce(into: 0) { partialResult, tuple in
            partialResult += tuple.element * (tuple.offset + 1)
        }
    }
}

struct Hand: Comparable {
    let cards: String
    let bid: Int
    let type: String
    var hasJoker: Bool { cards.filter { $0 == "J" }.count != 0 }
    var wildCard: String {
        guard hasJoker, isWildCardEnabled else { return cards }
        
        let trimmed = cards.replacingOccurrences(of: "J", with: "")
        var wilded = cards
        
        if trimmed.isHighCard {
            let a = Array(trimmed).max(by: { $0.cardStrength < $1.cardStrength }) ?? "A"
            wilded.replace(/J/, with: "\(a)")
        } else {
            wilded.replace(/J/, with: "\(trimmed.mostAndHighestOccurred)")
        }
        
        return wilded
    }
    
    init(cards: Substring, bid: Substring) throws {
        self.cards = String(cards)
        self.bid = try bid.toInteger()
        let typeIndex = [
            "\(cards)".isFiveOfAKind,
            "\(cards)".isFourOfAKind,
            "\(cards)".isFullHouse,
            "\(cards)".isThreeOfAKind,
            "\(cards)".isTwoPair,
            "\(cards)".isPair,
            "\(cards)".isHighCard
        ].firstIndex(where: { $0 })!
        self.type = [
            "fiveOfAKind",
            "fourOfAKind",
            "isFullHouse",
            "threeOfAKind",
            "twoPairs",
            "onePair",
            "highCard"
        ][typeIndex]
    }
    
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        let hasHighestSingleCard: (Hand, Hand) -> Bool = { lhs, rhs in
            let (a, b) = zip(Array(lhs.cards), Array(rhs.cards))
                .first(where: { $0 != $1 })!
            
            return a.cardStrength < b.cardStrength
        }
        
        let leftCards = lhs.wildCard
        let rightCards = rhs.wildCard
        
        if leftCards.handStrength == rightCards.handStrength {
            return hasHighestSingleCard(lhs, rhs)
        } else {
            return leftCards.handStrength < rightCards.handStrength
        }
    }
}

private extension String {
    var isFiveOfAKind: Bool {
        lazy.allSatisfy { $0 == first! }
    }
    
    var isFourOfAKind: Bool {
        lazy.contains(where: { char in filter { $0 == char }.count == 4 })
    }
    
    var isFullHouse: Bool {
        guard let a = first(where: { char in filter { $0 == char }.count == 3 }) else {
            return false
        }
        
        let trimmed = replacingOccurrences(of: "\(a)", with: "")
        return trimmed.allSatisfy { $0 == trimmed.first! }
    }
    
    var isThreeOfAKind: Bool {
        lazy.contains(where: { char in filter { $0 == char }.count == 3 })
    }
    
    var isTwoPair: Bool {
        guard let a = first(where: { char in filter { $0 == char }.count == 2 })
        else {
            return false
        }
        
        guard let b = filter({ $0 != a }).first(where: { char in filter { $0 == char }.count == 2 })
        else {
            return false
        }
        
        return a != b
    }
    
    var isPair: Bool {
        lazy.contains(where: { char in filter { $0 == char }.count == 2 })
    }
    
    var isHighCard: Bool {
        !lazy.contains(where: { char in filter { $0 == char }.count > 1 })
    }
    
    var handStrength: Int {
        if isFiveOfAKind {
            return 700
        } else if isFourOfAKind {
            return 600
        } else if isFullHouse {
            return 500
        } else if isThreeOfAKind {
            return 400
        } else if isTwoPair {
            return 300
        } else if isPair {
            return 200
        } else if isHighCard {
            return 100
        } else {
            fatalError()
        }
    }
    
    var mostAndHighestOccurred: Character {
        var dict: [Character: Int] = [:]
        
        for char in self {
            dict[char, default: 0] += 1
        }
        
        let maxOccurrence = dict.max(by: { $0.value < $1.value })!.value
        let filtered = dict.filter { $0.value == maxOccurrence }
        
        return filtered.max(by: { $0.key.cardStrength < $1.key.cardStrength })!.key
    }
}

private extension Character {
    var cardStrength: Int {
        if let value = try? toInteger() {
            return value
        } else {
            switch self {
            case "A": return 50
            case "K": return 40
            case "Q": return 30
            case "J": return isWildCardEnabled ? 1 : 20
            case "T": return 10
            default: fatalError()
            }
        }
    }
}
