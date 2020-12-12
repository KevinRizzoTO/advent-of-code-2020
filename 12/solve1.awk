@include "math"

{
  directions[NR] = $0
} 

END {
  x = 0
  y = 0

  # north 0, east 90, south 180, west 270
  facing = 90

  for (i in directions) {
    d = directions[i]

    match(d, /([N|S|E|W|L|R|F])([0-9]+)/, matches) 

    dir = matches[1]
    amount = matches[2]

    if (dir == "N") {
      y += amount
    } else if (dir == "S") {
      y -= amount
    } else if (dir == "E") {
      x += amount 
    } else if (dir == "W") {
      x -= amount
    } else if (dir == "L") {
      facing = (facing - amount + 360) % 360
    } else if (dir == "R") {
      facing = (facing + amount + 360) % 360
    } else if (dir == "F" && facing == 0) {
      y += amount  
    } else if (dir == "F" && facing == 90) {
      x += amount 
    } else if (dir == "F" && facing == 180) {
      y -= amount
    } else if (dir == "F" && facing == 270) {
      x -= amount
    }
  }

  print(abs(x) + abs(y))
}
