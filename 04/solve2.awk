BEGIN {
  RS="\n\n"
}

{
  gsub(/\n/, " ", $0)

  # http://gamon.webfactional.com/regexnumericrangegenerator/ 🚀
  byr = match($0, /byr:(19[2-8][0-9]|199[0-9]|200[0-2])/)
  iyr = match($0, /iyr:(201[0-9]|2020)/)
  eyr = match($0, /eyr:(202[0-9]|2030)/)
  hgt = match($0, /hgt:((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)/)
  hcl = match($0, /hcl:#([0-9]|[a-f]){6}(\s|$)/)
  ecl = match($0, /ecl:(amb|blu|brn|gry|grn|hzl|oth)/)
  pid = match($0, /pid:[0-9]{9}(\s|$)/)

  if (byr && iyr && eyr && hgt && hcl && ecl && pid) {
    matches++
  }
}

END {
  print(matches)
}
