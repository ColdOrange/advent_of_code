package part2

import (
	"strconv"
	"strings"
)

var Days = 256

func Solve(input string) string {
	result := 0
	for _, cycle := range strings.Split(input, ",") {
		n, _ := strconv.Atoi(cycle)
		result += a[Days-n]
	}
	return strconv.Itoa(result)
}

var a [257]int

func init() {
	// dp: f(n) = f(n-7) + f(n-9)
	for i := 1; i <= 256; i++ {
		a[i] = f(i-7) + f(i-9)
	}
}

func f(n int) int {
	if n > 0 {
		return a[n]
	}
	return 1
}
