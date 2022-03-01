package part1

import (
	"bufio"
	"strconv"
	"strings"

	"aoc/day8/part2"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	sum := 0
	for scanner.Scan() {
		s := strings.Split(scanner.Text(), " | ")
		patterns, numbers := strings.Split(s[0], " "), strings.Split(s[1], " ")
		sum += count(patterns, numbers)
	}
	return strconv.Itoa(sum)
}

func count(patterns []string, numbers []string) int {
	result := 0
	for _, n := range part2.ParseNumbers(patterns, numbers) {
		if n == 1 || n == 4 || n == 7 || n == 8 {
			result += 1
		}
	}
	return result
}
