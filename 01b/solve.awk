#! /usr/local/bin/gawk -f 

{ 
  arr[NR] = $1
  map[$1] = NR
}

END {
  for (i in arr) {
    for (j = i + 1; j < length(arr); j++) {
      diff = 2020 - (arr[i] + arr[j])
      if (map[diff]) {
        print diff * arr[i] * arr[j]
        exit 1
      }
    }
  }
}
