BEGIN {
  adapters[1] = 0
}

{
  adapters[NR + 1] = $0
}

END {
  asort(adapters)

  adapters_length = length(adapters)

  # Add device to list of adapters
  adapters[adapters_length + 1] = adapters[adapters_length] + 3

  for (i = 2; i <= length(adapters); i++) {
    curr = adapters[i]
    last = adapters[i - 1]

    if (curr - last == 3) {
      jolt3++
    } else if (curr - last == 1) {
      jolt1++
    }
  }

  print(jolt1 * jolt3)
}
