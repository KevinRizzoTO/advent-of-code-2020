BEGIN {
  FS=","
}

NR == 2 {
  for (field = 1; field <= NF; field++) {
    bus_ids[field] = $field
  }
}

END {
  step = 1

  for (i in bus_ids) {
    bus = bus_ids[i]

    if (bus == "x") {
      continue
    }

    while ((time + i - 1) % bus != 0) {
      time += step    
    }
    
    step *= bus
  }

  print(time)
}
