function get_invalid_number(start, line, arr,   i, j) {
  for (i = start; i <= length(arr) - 1; i++) {
    for (j = i + 1; j <= length(arr); j++) {
      if (arr[i] != arr[j] && arr[i] + arr[j] == line) {
        return 0
      }
    }
  }

  return line
}

function get_weakness(sum_to_find, arr,   ni, nj, sum, min, max, i, j) {
  for (i = 1; i <= length(arr) - 1; i++) {
    ni = arr[i]

    sum = ni
    min = ni
    max = ni

    for (j = i + 1; j <= length(arr); j++) {
      nj = arr[j]

      sum += nj
      min = nj < min ? nj : min
      max = nj > max ? nj : max

      if (sum == sum_to_find) {
        return min + max
      }
    }
  }

  return 0
}

{
  if (!invalid_num && NR > pa_length) {
    pa_start++
    invalid_num = get_invalid_number(pa_start, $0, numbers)
  }

  numbers[NR] = $0
}

END {
  printf("Part 1: %s\n", invalid_num)
  printf("Part 2: %s\n", get_weakness(invalid_num, numbers))
}
