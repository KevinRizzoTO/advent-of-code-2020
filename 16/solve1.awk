function add_to_valid(num) {
  v_num++

  valid[v_num] = num
}

function add_to_nearby(num) {
  n_num++

  nearby[n_num] = num
}

$0 ~ /^.*: [0-9]+/{
  match($0, /^.*: ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$/, valid_matches)

  for (i = valid_matches[1]; i <= valid_matches[2]; i++) {
    add_to_valid(i) 
  }

  for (i = valid_matches[3]; i <= valid_matches[4]; i++) {
    add_to_valid(i) 
  }
}

$0 ~ /nearby tickets/ {
  nearby_start = NR + 1
}

NR >= nearby_start {
  if (nearby_start > 0) {
    split($0, nearby_matches, ",")

    for (i = 1; i <= length(nearby_matches); i++) {
      add_to_nearby(nearby_matches[i])
    }
  }
}

END {
  for (i in nearby) {
    found = 0
    for (j in valid) {
      if (valid[j] == nearby[i]) {
        found = 1
        break
      }
    }

    if (!found) {
      sum += nearby[i]
    }
  }

  print(sum)
}
