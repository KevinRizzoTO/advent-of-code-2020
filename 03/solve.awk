function set_start(line) {
  start = (start + right) % length(line)
}

NR == 1 {
  set_start($0)
}

NR != 1 {
  # NR should be zero based so we know if we are on the n-th line
  checkLine = down > 1 ? (NR - 1) % down == 0 : 1

  if (checkLine && substr($0, start + 1, 1) == "#") {
    trees++
  }

  if (checkLine) {
    set_start($0)
  }
}

END {
  print(trees)
}
