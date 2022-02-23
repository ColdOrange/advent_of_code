package part1

import (
	"testing"

	"aoc/testdata"
)

func TestPart1(t *testing.T) {
	err, cases := testdata.Get(5, 1)
	if err != nil {
		t.Fatal(err)
	}

	for _, c := range cases {
		if got, want := Solve(c.Input), c.Output; got != want {
			t.Errorf("got %v, want %v", got, want)
		}
	}
}
