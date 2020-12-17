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

function join(arr,   str, i) {
  for (i in arr) { 
    str = str""arr[i]
  }

  return str
}

function push(arr, val) {
  arr[length(arr) + 1] = val
}

function make_arr(v) {
  v[1] = 1
  delete v[1]
}
