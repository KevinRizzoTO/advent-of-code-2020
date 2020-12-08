{
  lines[NR] = $0
}

END {
  i = 1
  while (i <= length(lines)) {
    if (tally[i] == "DONE") {
      break
    }

    tally[i] = "DONE"

    str = lines[i]    

    match(str, /^([a-z]+) ([+|-][0-9]+)/, matches)

    op = matches[1]
    arg = matches[2]

    if (op == "acc") {
      acc += arg
      i++
    } else if (op == "jmp") {
      i += arg
    } else if (op == "nop") {
      i++
    }
  }

  print(acc)
}
