BEGIN {
  FS=","
}

NR == 1 {
  start_minute = $0
}

NR == 2 {
  for (field = 1; field <= NF; field++) {
    if ($field != "x") {
      bus_ids[field] = $field
    }
  }
}

END {
  arrival_minute = start_minute - 1

  while (!earliest_bus) {
    arrival_minute++

    for (i in bus_ids) {
      if (arrival_minute % bus_ids[i] == 0) {
        earliest_bus = bus_ids[i]
        break
      }
    }
  }

  wait_time = arrival_minute - start_minute

  print(wait_time * earliest_bus)
}
