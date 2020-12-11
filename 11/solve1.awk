@include "../utils.awk"

{
  split($0, row, "")

  for (i in row) {
    seats[NR][i] = row[i]
  }
}

function is_occupied(seat) {
  return seat == "#"
}

function is_empty(seat) {
  return seat == "L"
}

function is_floor(seat) {
  return seat == "."
}

function get_seat(rowIndex, seatIndex,   n) {
  n = length(seats[rowIndex])

  if (int(seatIndex) < 1 || int(seatIndex) > n) {
    return 0
  }

  return seats[rowIndex][seatIndex]
}

function is_valid_point(row, seat) {
  if (row > length(seats) || row < 1) {
    return 0
  }

  if (seat < 1 || seat > length(seats[1])) {
    return 0
  }

  return 1
}

function occupied_seat_in_sight(start_row, start_seat, dir,    seat) {
  if (dir == "n") {
    start_row--
  } else if (dir == "nw") {
    start_row--
    start_seat--
  } else if (dir == "ne") {
    start_row--
    start_seat++
  } else if (dir == "w") {
    start_seat--
  } else if (dir == "e") {
    start_seat++
  } else if (dir == "s") {
    start_row++
  } else if (dir == "sw") {
    start_row++
    start_seat--
  } else if (dir == "se") {
    start_row++
    start_seat++
  }

  if (!is_valid_point(start_row, start_seat)) {
    # past the grid, no seat in sight
    return 0
  }

  seat = get_seat(start_row, start_seat)

  if (is_occupied(seat)) {
    return 1
  }

  return 0
}

function get_adjacent_occupied(rowIndex, seatIndex,    occupied) {
  rowIndex = int(rowIndex)
  seatIndex = int(seatIndex)

  n = occupied_seat_in_sight(rowIndex, seatIndex, "n")
  nw = occupied_seat_in_sight(rowIndex, seatIndex, "nw")
  ne = occupied_seat_in_sight(rowIndex, seatIndex, "ne")
  w = occupied_seat_in_sight(rowIndex, seatIndex, "w")
  e = occupied_seat_in_sight(rowIndex, seatIndex, "e")
  s = occupied_seat_in_sight(rowIndex, seatIndex, "s")
  sw = occupied_seat_in_sight(rowIndex, seatIndex, "sw")
  se = occupied_seat_in_sight(rowIndex, seatIndex, "se")

  return n + nw + ne + w + e + s + sw + se
}

function reset_seats(   i, j) {
  for (i in new_seats) {
    for (j in new_seats[i]) {
      seats[i][j] = new_seats[i][j]
    }
  }
}

function print_round(  i) {
  round++
  printf("Round %s:\n\n", round)
  for (i in new_seats) {
    print(join(new_seats[i]))
  }

  print("\n")
}

END {
  while(!in_sync) {
    new = ""

    for (i in seats) {
      for (j in seats[i]) {
        seat = seats[i][j]
        
        occ = 0
        if (!is_floor(seat)) {
          occ = get_adjacent_occupied(i, j)
        }

        if (is_empty(seat) && occ == 0) {
          new_seats[i][j] = "#"
        } else if (is_occupied(seat) && occ >= 4) {
          new_seats[i][j] = "L"
        } else {
          new_seats[i][j] = seat
        }

        new = new""new_seats[i][j]
      }
    }

    in_sync = new == last
    last = new
    reset_seats()

    if (debug) {
      print_round()
    }
  }

  gsub(/[^#]/, "", new) 

  print(length(new))
}
