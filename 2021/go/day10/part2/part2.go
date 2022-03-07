package part2

import (
	"bufio"
	"sort"
	"strconv"
	"strings"

	"aoc/day10/part1"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var scores []int
	for scanner.Scan() {
		parser := part1.NewParser(scanner.Text())
		if parser.Parse() == part1.Incomplete {
			scores = append(scores, points(parser.Completion()))
		}
	}
	sort.Ints(scores)
	return strconv.Itoa(scores[len(scores)/2])
}

func points(chars []byte) int {
	result := 0
	for _, char := range chars {
		result = result*5 + point(char)
	}
	return result
}

func point(char byte) int {
	switch char {
	case ')':
		return 1
	case ']':
		return 2
	case '}':
		return 3
	case '>':
		return 4
	default:
		return 0
	}
}
