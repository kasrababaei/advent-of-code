extension ClosedRange where Bound: Numeric {
    var delta: Bound {
        upperBound - lowerBound
    }
}
