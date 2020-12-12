@include "math"

{
  directions[NR] = $0
} 

function rotate_waypoint(degree,   newX, newY) {
  if (degree == 90) {
    newX = pointY * -1
    newY = pointX
  } else if (degree == 180) {
    newX = pointX * -1
    newY = pointY * -1
  } else if (degree == 270) {
    newX = pointY
    newY = pointX * -1
  }

  pointX = newX
  pointY = newY
}

END {
  shipX = 0
  shipY = 0

  pointX = 10
  pointY = 1

  for (i in directions) {
    d = directions[i]

    match(d, /([N|S|E|W|L|R|F])([0-9]+)/, matches) 

    dir = matches[1]
    amount = matches[2]

    switch (dir) {
      case "N":
        pointY += amount
        break
      case "S":
        pointY -= amount
        break
      case "E":
        pointX += amount
        break
      case "W":
        pointX -= amount
        break
      case "R":
        dir = "L"
        amount = 360 - amount
      case "L":
        rotate_waypoint(amount)        
        break
      case "F":
        shipX += pointX * amount
        shipY += pointY * amount
        break
    }
  }

  print(abs(shipX) + abs(shipY))
}
