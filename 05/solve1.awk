@include "../utils"

BEGIN {
  FS=""
}

{
  high = 127
  low = 0
  row = 0 # to set later

  for (i = 1; i <= NF; i++) {
    v = $i
    half = (high - low) / 2

    if (v == "F" || v == "L") {
      high = floor(high - half)
    } else if (v == "B" || v == "R") {
      low = ceil(low + half)
    }

    if (i == 7) {
      # final row so set the value
      row = high
      # reset values to match the seat numbers
      high = 7
      low = 0
    }
  }

  seat_id = row * 8 + high

  if (seat_id > max_id) {
    max_id = seat_id
  }
}

END {
  print(max_id)
}
