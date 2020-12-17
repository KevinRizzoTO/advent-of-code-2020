@include "../utils.awk"

$0 ~ /^.*: [0-9]+/{
  match($0, /^(.*): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$/, valid_matches)

  for (i = 1; i <= 4; i++) {
    field_ranges[valid_matches[1]][i] = valid_matches[i + 1]
  }
}

$0 ~ /nearby tickets/ {
  nearby_start = NR + 1
}

$0 ~ /your ticket/ {
  your_ticket_index = NR + 1
}

NR == your_ticket_index {
  split($0, your_ticket, ",")
}

nearby_start && NR >= nearby_start {
  split($0, nearby_matches, ",")

  if (is_valid_ticket(nearby_matches)) {
    valid_ticket_count++
  }
}

function is_valid_ticket(ticket,    num, i, field, min1, max1, min2, max2, valid1, valid2, v, v_count) {
  for (i in ticket) {
    num = ticket[i]
    v = 0
    for (field in field_ranges) {
      min1 = field_ranges[field][1]
      max1 = field_ranges[field][2]
      min2 = field_ranges[field][3]
      max2 = field_ranges[field][4]

      valid1 = num >= min1 && num <= max1
      valid2 = num >= min2 && num <= max2

      if (valid1 || valid2) {
        v_count[i][field]++
        v++  
      } 
    }

    if (!v) {
      return 0
    }
  }

  for (i in v_count) {
    for (field in v_count[i]) {
      # append to global count
      valid_count[i][field] += v_count[i][field]
    }
  }

  return 1
}

function remove_found_fields(fields,   i, field, j) {
  for (i in fields) {
    field = fields[i]

    for (j in valid_count) {
      delete valid_count[j][field]
    }
  }
}

END {
  column_total = length(valid_count)

  make_arr(column_fields)

  while(length(column_fields) < column_total) {
    for (c in valid_count) {
      found_field = ""
      matches_all = 0

      for (f in valid_count[c]) {
        if (valid_count[c][f] == valid_ticket_count) {
          found_field = f
          matches_all++
        }
      }

      if (matches_all == 1) {
        column_fields[c] = found_field
      }
    }

    remove_found_fields(column_fields)
  }

  final = 1

  for (i in column_fields) {
    if (column_fields[i] ~ /departure/) {
      final *= your_ticket[i]
    }
  }

  print(final)
}
