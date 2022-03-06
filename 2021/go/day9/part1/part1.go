package part1

import (
	"bufio"
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
	return strconv.Itoa(count(a))
}

func count(a [][]int) int {
	result := 0
	for r, row := range a {
		for c, n := range row {
			if check(a, r, c, n) {
				result += n + 1
			}
		}
	}
	return result
}

func check(a [][]int, r, c int, n int) bool {
	for i := -1; i <= 1; i++ {
		for j := -1; j <= 1; j++ {
			if i+j != -1 && i+j != 1 {
				continue
			}
			if border(a, r+i, c+j) {
				continue
			}
			if n >= a[r+i][c+j] {
				return false
			}
		}
	}
	return true
}

func border(a [][]int, r, c int) bool {
	return r < 0 || r >= len(a) || c < 0 || c >= len(a[0])
}
