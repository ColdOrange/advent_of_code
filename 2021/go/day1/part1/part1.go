package part1

import (
	"bufio"
	"strconv"
	"strings"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var list []int
	for scanner.Scan() {
		n, _ := strconv.Atoi(scanner.Text())
		list = append(list, n)
	}
	return strconv.Itoa(increases(list))
}

func increases(list []int) int {
	result := 0
	for i := 1; i < len(list); i++ {
		if list[i] > list[i-1] {
			result++
		}
	}
	return result
}
