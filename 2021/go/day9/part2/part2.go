package part2

import (
	"bufio"
	"sort"
	"strconv"
	"strings"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var a [][]int
	for scanner.Scan() {
		var row []int
		for _, n := range scanner.Text() {
			row = append(row, int(n-'0'))
		}
		a = append(a, row)
	}
	return strconv.Itoa(calc(a))
}

func calc(a [][]int) int {
	var basin []int
	for r, row := range a {
		for c := range row {
			size := visit(a, r, c)
			if size != 0 {
				basin = append(basin, size)
			}
		}
	}

	sort.Slice(basin, func(i, j int) bool {
		return basin[i] > basin[j]
	})
	return basin[0] * basin[1] * basin[2]
}

func visit(a [][]int, r, c int) int {
	if border(a, r, c) {
		return 0
	}
	if a[r][c] == 9 {
		return 0
	}
	a[r][c] = 9 // mark visited
	return 1 + visit(a, r-1, c) + visit(a, r+1, c) + visit(a, r, c-1) + visit(a, r, c+1)
}

func border(a [][]int, r, c int) bool {
	return r < 0 || r >= len(a) || c < 0 || c >= len(a[0])
}
