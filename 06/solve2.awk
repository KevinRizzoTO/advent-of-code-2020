BEGIN {
  RS="\n\n"
}

{
  split($0, group, "\n")

  for (person in group) {
    split(group[person], p, "")

    for (a in p) {
      answer = p[a]
      answers[answer]++

      if (answers[answer] == length(group)) {
        sum++
      }
    }
  }

  delete answers
}

END {
  print(sum)
}

