extension Array where Element == Int {
    var sum: Int {
        reduce(into: 0) { $0 += $1 }
    }
}

extension Array where Element == Double {
    var sum: Double {
        reduce(into: 0) { $0 = $0 + ($1) }
    }
}

extension Array where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        first!.indices
            .map { index in
                map { $0[index] }
            }
    }
    
    func prettyPrint() {
        for row in self {
            let string = row.reduce(into: "") { $0 += "\($1)"}
            print(string)
        }
    }
}
