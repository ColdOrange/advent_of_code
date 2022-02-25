package part2

import (
	"math"
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
	// see proof_of_part2.pdf
	meanFloor, meanCeil := mean(points)
	sum1, sum2 := 0, 0
	for _, point := range points {
		sum1 += abs(point-meanFloor) * (abs(point-meanFloor) + 1) / 2
		sum2 += abs(point-meanCeil) * (abs(point-meanCeil) + 1) / 2
	}
	return min(sum1, sum2)
}

func mean(points []int) (int, int) {
	sum := 0
	for _, point := range points {
		sum += point
	}
	mean := float64(sum) / float64(len(points))
	return int(math.Floor(mean)), int(math.Ceil(mean))
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}
