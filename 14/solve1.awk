@include "math"

function reverse(str,   i, revStr) {
  for (i = length(str); i > 0; i--) {
    revStr = revStr""substr(str, i, 1)  
  }

  return revStr
}

function turn_on_bit(num, bit,   on) {
  on = lshift(1, bit)

  return or(num, on)
}

function turn_off_bit(num, bit,   off, bin, newBin, b, i, n) {
  off = lshift(1, bit)

  return and(num, compl(off))
}

function set(num, state, bit) {
  if (state == 1) {
    return turn_on_bit(num, bit)
  }

  return turn_off_bit(num, bit)
}

function process_mask(mask, value,   i, b) {
  mask = reverse(mask)

  for (i = length(mask); i > 0; i--) {
    b = substr(mask, i, 1)

    if (b == "X") {
      continue
    }

    value = set(value, int(b), i - 1)
  }

  return value
}

{
  program[NR] = $0
}

END {
  for (i in program) {
    curr = program[i]

    if (curr ~ /^mask/) {
      match(curr, /^mask = (.*)$/, matches)
      m = matches[1]
    } else if (curr ~ /^mem/) {
      match(curr, /^mem\[([0-9]+)\] = ([0-9]+)/, matches)
      address = matches[1]
      value = matches[2]

      memory[address] = process_mask(m, value)
       
      #print(m, change_base(value, 10, 2), change_base(memory[address], 10, 2))
    }

    delete matches
  }

  for (i in memory) {
    finalSum += memory[i]
  }

  print(finalSum)
}
