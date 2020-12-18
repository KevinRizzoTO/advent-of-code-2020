package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

type point struct {
	x, y, z, w int
}

type matrix map[point]bool

func (m matrix) getNeighbours(p point) []point {
	neighbours := []point{}
	for x := -1; x <= 1; x++ {
		for y := -1; y <= 1; y++ {
			for z := -1; z <= 1; z++ {
				for w := -1; w <= 1; w++ {
					if !(x == 0 && y == 0 && z == 0 && w == 0) {
						n := point{x: p.x + x, y: p.y + y, z: p.z + z, w: p.w + w}

						neighbours = append(neighbours, n)
					}
				}
			}
		}
	}

	return neighbours
}

func (m matrix) getActiveCountForPoints(pS []point) int {
	activeCount := 0

	for _, p := range pS {
		if m[p] {
			activeCount++
		}
	}

	return activeCount
}

func (m matrix) getActiveCountForAll() int {
	activeCount := 0

	for _, p := range m {
		if p {
			activeCount++
		}
	}

	return activeCount
}

func (m matrix) getNext() matrix {
	newState := matrix{}
	changes := matrix{}

	for p, active := range m {
		n := m.getNeighbours(p)
		for _, ni := range n {
			_, ok := m[ni]

			if !ok {
				newState[ni] = false
			}
		}

		newState[p] = active
	}

	for p, active := range newState {
		n := newState.getNeighbours(p)
		activeCount := newState.getActiveCountForPoints(n)

		if active && activeCount != 2 && activeCount != 3 {
			changes[p] = false
		} else if !active && activeCount == 3 {
			changes[p] = true
		}
	}

	for p, active := range changes {
		newState[p] = active
	}

	return newState
}

func getActive(s string) bool {
	if s == "#" {
		return true
	}

	return false
}

func main() {
	dat, err := ioutil.ReadFile("./input.txt")
	check(err)

	lines := strings.Split(string(dat), "\n")
	lines = lines[:len(lines)-1]

	m := matrix{}

	for y, line := range lines {
		for x, s := range strings.Split(line, "") {
			m[point{x: x, y: y}] = getActive(s)
		}
	}

	for i := 1; i <= 6; i++ {
		m = m.getNext()
	}

	fmt.Println(m.getActiveCountForAll())
}
