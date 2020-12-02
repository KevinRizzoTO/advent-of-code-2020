#! /usr/local/bin/gawk -f 

BEGIN { 
  FS=": "
}

{
  match($1, /([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]])/, criteria)
  first = criteria[1]
  second = criteria[2]
  letter = criteria[3]

  found_first = substr($2, first, 1) == letter
  found_second = substr($2, second, 1) == letter

  if ((found_first && !found_second) || (found_second && !found_first)) {
    final[NR] = $0
  }
}

END {
  printf("There are %s valid passwords.", length(final))
}
