import Foundation
import RegexBuilder

struct Y2024Day09: AdventDay {
  let data: String
  
  func part1() throws -> Any {
    let diskMap = try diskMap()
    
    var fileBlockIndex = diskMap.endIndex
    var freeSpaceIndex = diskMap.startIndex
    
    
    return 0
  }
  
  func part2() throws -> Any {
    return 0
  }
}

private extension Y2024Day09 {
  func diskMap() throws -> String {
    let digits = try Array(data).map { try $0.toInteger() }
    var diskMap = ""
    
    var firstFreeSpaceIndex: String.Index?
    var lastFileSpaceIndex: String.Index?
    
    for index in stride(from: 0, to: digits.count, by: 2) {
      diskMap += String(repeating: "\(index / 2)", count: digits[index])
      if digits.indices.contains(index + 1) {
        diskMap += String(repeating: ".", count: digits[index + 1])
      }
    }
    
    return diskMap
  }
  
  struct DiskMap {
    let string: String
    let firstFreeSpaceIndex: String.Index
    let lastFileSpaceIndex: String.Index
    
    init(
      _ string: String,
      _ firstFreeSpaceIndex: String.Index,
      _ lastFileSpaceIndex: String.Index
    ) {
      self.string = string
      self.firstFreeSpaceIndex = firstFreeSpaceIndex
      self.lastFileSpaceIndex = lastFileSpaceIndex
    }
  }
}

