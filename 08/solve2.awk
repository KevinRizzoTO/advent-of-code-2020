function loopDetected() {
  delete tally
  i = 1
  acc = 0

  changeState++
  indexToChange = changes[changeState]
}

$0 ~ /[nop|jmp]/ {
  changeCount++

  changes[changeCount] = NR
}

{
  lines[NR] = $0
}

END {
  loopDetected()

  s["jmp"] = "nop"
  s["nop"] = "jmp"

  while (i <= length(lines)) {
    if (tally[i] == "DONE") {
      loopDetected()
      continue
    }

    tally[i] = "DONE"

    str = lines[i]    

    match(str, /^([a-z]+) ([+|-][0-9]+)/, matches)

    op = matches[1]
    arg = matches[2]

    if (i == indexToChange) {
      op = s[op]
    }

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
