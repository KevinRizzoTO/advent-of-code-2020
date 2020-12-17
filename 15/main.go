package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func check(err error) {
	if err != nil {
		panic(err)
	}
}

func initializeVariables(nums []string) (map[int][]int, int, int) {
	numsForTurn := map[int][]int{}
	var lastSpoke int

	for i, n := range nums {
		num, err := strconv.Atoi(n)
		check(err)

		s := []int{i + 1}
		numsForTurn[num] = s
		lastSpoke = num
	}

	return numsForTurn, lastSpoke, len(nums) + 1
}

func Part1(startingNumbers []string) int {
	return run(startingNumbers, 2020)
}

func Part2(startingNumbers []string) int {
	return run(startingNumbers, 30000000)
}

func run(startingNumbers []string, end int) int {
	numsForTurn, lastSpoke, turn := initializeVariables(startingNumbers)

	for i := turn; i <= end; i++ {
		if len(numsForTurn[lastSpoke]) == 1 {
			numsForTurn[0] = append(numsForTurn[0], i)
			lastSpoke = 0
		} else {
			lastSlice := numsForTurn[lastSpoke]

			last := lastSlice[len(lastSlice)-1]
			secondLast := lastSlice[len(lastSlice)-2]

			lastSpoke = last - secondLast
			numsForTurn[lastSpoke] = append(numsForTurn[lastSpoke], i)
		}
	}

	return lastSpoke
}

func main() {
	input, err := ioutil.ReadFile("./input.txt")
	check(err)

	startingNumbers := strings.Split(strings.ReplaceAll(string(input), "\n", ""), ",")

	fmt.Printf("Part 1: %d", Part1(startingNumbers))
	fmt.Println()
	fmt.Printf("Part 2: %d", Part2(startingNumbers))
}
