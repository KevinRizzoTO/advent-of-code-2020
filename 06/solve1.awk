BEGIN {
  RS="\n\n"
}

{
  gsub(/\s/, "", $0)

  split($0, group, "")

  for (a in group) {
    answer = group[a]
    if (answers[answer] != "FOUND") {
      answers[answer] = "FOUND"
    } 
  }

  sum += length(answers)
  delete answers
}

END {
  print(sum)
}

