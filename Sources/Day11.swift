struct Day11: AdventDay {
    var data: String
    
    func part1() -> Any {
        lengthsSum(repeating: 2)
    }
    
    func part2(repeating repeatedValue: Int) -> Any {
        lengthsSum(repeating: repeatedValue)
    }
    
    private func lengthsSum(repeating repeatedValue: Int) -> Int {
        let matrix = data.to2DArray()
        
        var rowsIndices: [Int] = []
        var columnsIndices: [Int] = []
        
        for (index, row) in matrix.enumerated() {
            if !row.contains(where: { $0 == "#" }) {
                rowsIndices.append(index)
            }
            
            if !matrix.indices.map({ matrix[$0][index] }).contains(where: { $0 == "#" }) {
                columnsIndices.append(index)
            }
        }
        
        let coordinates: Set<Coordinate> = matrix
            .enumerated()
            .flatMap { (rowIndex, row) in
                row
                    .enumerated()
                    .compactMap { (columnIndex, char) -> Coordinate? in
                        guard char == "#" else { return nil }
                        return Coordinate(row: rowIndex, column: columnIndex)
                    }
            }
            .reduce(into: []) { $0.insert($1)}
        
        var distances: [Itinerary: Int] = [:]
        
        for source in coordinates {
            for destination in coordinates.subtracting([source]) {
                let itinerary = Itinerary(source: source, destination: destination)
                
                guard distances[itinerary] == nil && distances[itinerary.reversed()] == nil else {
                    continue
                }
                
                let minLat = min(source.row, destination.row)
                let maxLat = max(source.row, destination.row)
                let expandedLat = (minLat..<maxLat).reduce(into: 0) { partialResult, rowIndex in
                    partialResult += rowsIndices.contains(rowIndex) ? repeatedValue : 1
                }
                
                let minLong = min(source.column, destination.column)
                let maxLong = max(source.column, destination.column)
                let expandedLong = (minLong..<maxLong).reduce(into: 0) { partialResult, columnIndex in
                    partialResult += columnsIndices.contains(columnIndex) ? repeatedValue : 1
                }
                
                distances[itinerary] = expandedLat + expandedLong
            }
        }
        
        return distances.values.map { $0 }.sum
    }
}

struct Coordinate: Hashable {
    let row: Int
    let column: Int
}

struct Itinerary: Hashable {
    let source: Coordinate
    let destination: Coordinate
    
    func reversed() -> Self {
        Itinerary(source: destination, destination: source)
    }
}
