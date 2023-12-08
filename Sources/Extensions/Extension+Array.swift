extension Array where Element: Numeric {
    var sum: Element {
        reduce(into: 0) { $0 += $0 + $1 }
    }
}
