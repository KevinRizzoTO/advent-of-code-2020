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
  device_joltage = adapters[adapters_length] + 3
  adapters[adapters_length + 1] = device_joltage

  paths[adapters[1]] = 1

  for (i = 2; i <= length(adapters); i++) {
    paths[adapters[i]] = paths[adapters[i] - 1] + paths[adapters[i] - 2] + paths[adapters[i] - 3]
  }

  print(paths[device_joltage])
}
