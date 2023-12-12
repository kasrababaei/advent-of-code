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
