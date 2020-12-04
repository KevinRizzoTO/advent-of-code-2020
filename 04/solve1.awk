BEGIN {
  RS="\n\n"
}

{
  ecl = match($0, /(ecl)/)
  byr = match($0, /(byr)/)
  iyr = match($0, /(iyr)/)
  eyr = match($0, /(eyr)/)
  hgt = match($0, /(hgt)/)
  hcl = match($0, /(hcl)/)
  pid = match($0, /(pid)/)

  if (ecl && byr && iyr && eyr && hgt && hcl && pid) {
    matches++
  }
}

END {
  print(matches)
}
