import Algorithms

struct Y2025Day01: AdventDay {
  var data: String

  func part1() -> Any {
    let regex = /([A-Z])(\d*)/
    let lines = data.split(separator: "\n")
    var index = 50
    var result = 0

    for line in lines {
      let match = line.matches(of: regex)[0]
      let letter = String(match.output.1)
      var clicks = Int(match.output.2)!
      let sign = letter == "L" ? -1 : 1

      while clicks > 0 {
        if index + clicks * sign > 99 {
          clicks -= 100 - index
          index = 0
        } else if index + clicks * sign < 0 {
          clicks -= index + 1
          index = 99
        } else {
          index += clicks * sign
          clicks = 0
        }
      }

      if index == 0 {
        result += 1
      }
    }

    return result
  }

  func part2() -> Any {
    let regex = /([A-Z])(\d*)/
    let lines = data.split(separator: "\n")
    var index = 50
    var result = 0

    for line in lines {
      let match = line.matches(of: regex)[0]
      let letter = String(match.output.1)
      var clicks = Int(match.output.2)!
      let sign = letter == "L" ? -1 : 1

      while clicks > 0 {
        if sign == 1 {
          if index + clicks > 99 {
            let distanceToOneHundred = 100 - index
            clicks -= distanceToOneHundred
            index = 0
          } else {
            index += clicks
            clicks = 0
          }
        } else {
          if index == 0 {
            index = 99
            clicks -= 1
          } else {
            let distanceToZero = index - clicks < 0 ? max(1, index) : clicks
            clicks -= distanceToZero
            index -= distanceToZero
          }
        }

        if index == 0, clicks > 0 {
          result += 1
        }
      }

      if index == 0 {
        result += 1
      }
    }

    return result
  }
}
