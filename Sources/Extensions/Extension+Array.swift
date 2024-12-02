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

extension Array {
  /// Returns the same index if it's within bounds.
  ///
  /// When the index is negative, returns zero but when it's greater than the last index, returns
  /// the last index.
  func clamped(_ index: Int) -> Int {
    if indices.contains(index) {
      return index
    } else {
      return index < 0 ? 0 : count - 1
    }
  }
  
  /// Returns a new copy of `self` without the element at the given index.
  func removing(at index: Int) -> [Element] {
    var array = self
    array.remove(at: index)
    return array
  }
}
