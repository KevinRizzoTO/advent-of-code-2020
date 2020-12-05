BEGIN {
  FS=""
}

# https://stackoverflow.com/a/13696094
function bin2dec(n) {
  result = 0;
  if (n~/[^01]/) {
    return n;
  }
  for (i=length(n); i; i--) {
    result += 2^(length(n)-i) * substr(n,i,1);
  }
  return result;
}

{
  gsub(/(F|L)/, "0", $0)
  gsub(/(B|R)/, "1", $0)

  seat_ids[NR] = bin2dec($0)
}

END {
  asort(seat_ids)

  for (s in seat_ids) {
    if (seat_ids[s] + 1 != seat_ids[s + 1]) {
      print(seat_ids[s] + 1)
      exit 1
    }
  }
}
