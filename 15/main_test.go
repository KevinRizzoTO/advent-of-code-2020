package main

import (
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_Part1(t *testing.T) {
	var tests = []struct {
		in  string
		out int
	}{
		{
			in:  "0,3,6",
			out: 436,
		},
		{
			in:  "1,3,2",
			out: 1,
		},
		{
			in:  "2,1,3",
			out: 10,
		},
		{
			in:  "1,2,3",
			out: 27,
		},
		{
			in:  "2,3,1",
			out: 78,
		},
		{
			in:  "3,2,1",
			out: 438,
		},
		{
			in:  "3,1,2",
			out: 1836,
		},
	}

	for _, tt := range tests {
		t.Run(tt.in, func(t *testing.T) {
			actual := Part1(strings.Split(tt.in, ","))

			assert.Equal(t, tt.out, actual)
		})
	}
}

func Test_Part2(t *testing.T) {
	var tests = []struct {
		in  string
		out int
	}{
		{
			in:  "0,3,6",
			out: 175594,
		},
		{
			in:  "1,3,2",
			out: 2578,
		},
		{
			in:  "2,1,3",
			out: 3544142,
		},
		{
			in:  "1,2,3",
			out: 261214,
		},
		{
			in:  "2,3,1",
			out: 6895259,
		},
		{
			in:  "3,2,1",
			out: 18,
		},
		{
			in:  "3,1,2",
			out: 362,
		},
	}

	for _, tt := range tests {
		t.Run(tt.in, func(t *testing.T) {
			actual := Part2(strings.Split(tt.in, ","))

			assert.Equal(t, tt.out, actual)
		})
	}
}
