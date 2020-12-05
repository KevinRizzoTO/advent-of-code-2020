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

function ceil(val) {
  return int(val) + 1
}

function floor(val) {
  return int(val)
}