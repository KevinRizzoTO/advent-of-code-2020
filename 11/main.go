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

var (
	empty    = "L"
	occupied = "#"
	floor    = "."
)

type point struct {
	x, y int
}

type seat string

func (s seat) isEmpty() bool {
	return string(s) == empty
}

func (s seat) isOccupied() bool {
	return string(s) == occupied
}

func (s seat) isFloor() bool {
	return string(s) == floor
}

type matrix map[point]seat

func (m matrix) occupiedSeatInSight(p point, xDir int, yDir int) int {
	nextPoint := point{x: p.x + xDir, y: p.y + yDir}
	seat, ok := m[nextPoint]

	if !ok || seat.isEmpty() {
		return 0
	} else if seat.isOccupied() {
		return 1
	}

	return m.occupiedSeatInSight(nextPoint, xDir, yDir)
}

func (m matrix) getAdjacentOccupied(p point) int {
	n := m.occupiedSeatInSight(p, -1, 0)
	nw := m.occupiedSeatInSight(p, -1, -1)
	ne := m.occupiedSeatInSight(p, -1, 1)
	w := m.occupiedSeatInSight(p, 0, -1)
	e := m.occupiedSeatInSight(p, 0, 1)
	s := m.occupiedSeatInSight(p, 1, 0)
	sw := m.occupiedSeatInSight(p, 1, -1)
	se := m.occupiedSeatInSight(p, 1, 1)

	return n + nw + ne + w + e + s + sw + se
}

func (m matrix) getNext() (matrix, int) {
	newState := matrix{}
	changes := 0

	for p, s := range m {
		var newSeat seat
		if s.isEmpty() && m.getAdjacentOccupied(p) == 0 {
			newSeat = seat(occupied)
			changes++
		} else if s.isOccupied() && m.getAdjacentOccupied(p) >= 5 {
			newSeat = seat(empty)
			changes++
		} else {
			newSeat = s
		}

		newState[p] = newSeat
	}

	return newState, changes
}

func (m matrix) getOccupiedCount() int {
	count := 0
	for _, s := range m {
		if s.isOccupied() {
			count++
		}
	}

	return count
}

func main() {
	dat, err := ioutil.ReadFile("./input.txt")
	check(err)

	lines := strings.Split(string(dat), "\n")
	lines = lines[:len(lines)-1]

	m := matrix{}

	for y, line := range lines {
		for x, s := range strings.Split(line, "") {
			m[point{x, y}] = seat(s)
		}
	}

	in_sync := false

	for !in_sync {
		next, changes := m.getNext()
		if changes > 0 {
			m = next
		} else {
			in_sync = true
		}
	}

	fmt.Println(m.getOccupiedCount())
}
