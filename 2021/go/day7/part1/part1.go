package part1

import (
	"sort"
	"strconv"
	"strings"
)

func Solve(input string) string {
	var points []int
	for _, point := range strings.Split(input, ",") {
		n, _ := strconv.Atoi(point)
		points = append(points, n)
	}
	return strconv.Itoa(calc(points))
}

func calc(points []int) int {
	sort.Ints(points)
	median := points[(len(points)+1)/2]

	sum := 0
	for _, point := range points {
		sum += abs(point - median)
	}
	return sum
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}
