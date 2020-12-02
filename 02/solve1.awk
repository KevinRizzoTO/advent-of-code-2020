#! /usr/local/bin/gawk -f 

BEGIN { 
  FS=": "
}

{
  match($1, /([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]])/, criteria)
  min = criteria[1]
  max = criteria[2]
  letter = criteria[3]

  str = $2  
  regex = "[^"letter"]"

  gsub(regex, "", str)

  if (length(str) >= min && length(str) <= max) {
    final[NR] = $0
  }
}

END {
  print(length(final))
}
