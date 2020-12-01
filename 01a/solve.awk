#! /usr/local/bin/gawk -f 

{ 
  for (i in arr) {
    if (arr[i] + $1 == 2020) {
      print $1 * arr[i]
    }
  }

  arr[NR] = $1
}
