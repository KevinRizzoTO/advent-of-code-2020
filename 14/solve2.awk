function reverse(str,   i, revStr) {
  for (i = length(str); i > 0; i--) {
    revStr = revStr""substr(str, i, 1)  
  }

  return revStr
}

function turn_on_bit(num, bit,   on) {
  return or(num, lshift(1, bit))
}

function turn_off_bit(num, bit,   off) {
  off = lshift(1, bit)

  return and(num, compl(off))
}

function set(num, state, bit) {
  if (state == 1) {
    return turn_on_bit(num, bit)
  }

  return turn_off_bit(num, bit)
}

function push(arr, val) {
  arr[length(arr) + 1] = val
}

function add_to_memory(mask, value, address, mem,   i, b, addresses, a, to_add, ta) {
  mask = reverse(mask)
  addresses[1] = address

  for (i = length(mask); i > 0; i--) {
    b = substr(mask, i, 1)

    if (b == "X") {
      for (a in addresses) {
        add = addresses[a]

        addresses[a] = set(add, 0, i - 1)
        to_add[a] = set(add, 1, i - 1)
      }

      for (ta in to_add) {
        push(addresses, to_add[ta])
      }

      delete to_add
    } else if (b == 1) {
      for (a in addresses) {
        addresses[a] = set(addresses[a], 1, i - 1)
      }
    }
  }

  for (a in addresses) {
    mem[addresses[a]] = value
  }
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

      add_to_memory(m, value, address, memory)
    }

    delete matches
  }

  for (i in memory) {
    finalSum += memory[i]
  }

  print(finalSum)
}
