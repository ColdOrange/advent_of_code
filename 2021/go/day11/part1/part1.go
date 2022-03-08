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
	return strconv.Itoa(search(a))
}

func search(a [][]int) int {
	flashes := 0
	for i := 1; i <= 100; i++ {
		inc(a)
		flash(a)
		flashes += flashed(a)
	}
	return flashes
}

func inc(a [][]int) {
	for r, row := range a {
		for c, value := range row {
			a[r][c] = value + 1
		}
	}
}

func incNeighbors(a [][]int, r, c int) {
	for i := -1; i <= 1; i++ {
		for j := -1; j <= 1; j++ {
			if i == 0 && j == 0 {
				continue
			}
			if r+i < 0 || r+i >= len(a) || j+c < 0 || j+c >= len(a[0]) {
				continue
			}
			if a[r+i][j+c] != 0 {
				a[r+i][j+c] += 1
			}
		}
	}
}

func flash(a [][]int) {
	cont := false
	for r, row := range a {
		for c, value := range row {
			if value > 9 {
				a[r][c] = 0
				incNeighbors(a, r, c)
				cont = true
			}
		}
	}

	if cont {
		flash(a)
	}
}

func flashed(a [][]int) int {
	count := 0
	for _, row := range a {
		for _, value := range row {
			if value == 0 {
				count++
			}
		}
	}
	return count
}
