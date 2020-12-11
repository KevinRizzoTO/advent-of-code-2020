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

function occupied_seat_in_sight(start_row, start_seat, row_dir, seat_dir,    seat) {
  start_row += row_dir
  start_seat += seat_dir

  if (!is_valid_point(start_row, start_seat)) {
    # past the grid, no seat in sight
    return 0
  }

  seat = get_seat(start_row, start_seat)

  if (is_empty(seat)) {
    return 0
  } else if (is_occupied(seat)) {
    return 1
  }

  return occupied_seat_in_sight(start_row, start_seat, row_dir, seat_dir)
}

function get_adjacent_occupied(rowIndex, seatIndex,    occupied) {
  rowIndex = int(rowIndex)
  seatIndex = int(seatIndex)

  n = occupied_seat_in_sight(rowIndex, seatIndex, -1, 0)
  nw = occupied_seat_in_sight(rowIndex, seatIndex, -1, -1)
  ne = occupied_seat_in_sight(rowIndex, seatIndex, -1, 1)
  w = occupied_seat_in_sight(rowIndex, seatIndex, 0, -1)
  e = occupied_seat_in_sight(rowIndex, seatIndex, 0, 1)
  s = occupied_seat_in_sight(rowIndex, seatIndex, 1, 0)
  sw = occupied_seat_in_sight(rowIndex, seatIndex, 1, -1)
  se = occupied_seat_in_sight(rowIndex, seatIndex, 1, 1)

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
  for (i in new_seats) {
    print(join(new_seats[i]))
  }
}

END {
  while(!in_sync) {
    new = ""

    for (i in seats) {
      for (j in seats[i]) {
        seat = seats[i][j]

        if (is_empty(seat) && get_adjacent_occupied(i, j) == 0) {
          new_seats[i][j] = "#"
        } else if (is_occupied(seat) && get_adjacent_occupied(i, j) >= 5) {
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
      round++
      printf("Round %s:\n\n", round)
    
      print_round()

      print("\n")
    }
  }

  gsub(/[^#]/, "", new) 

  print(length(new))
}
