package part2

import (
	"bufio"
	"strconv"
	"strings"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var numbers []string
	for scanner.Scan() {
		numbers = append(numbers, scanner.Text())
	}
	return strconv.Itoa(calc(numbers))
}

func calc(numbers []string) int {
	return filter(numbers, MostCommon) * filter(numbers, LeastCommon)
}

const (
	MostCommon = iota
	LeastCommon
)

func filter(numbers []string, filterType int) int {
	for bit := 0; len(numbers) > 1; bit++ {
		var bit1, bit0 []string
		for _, number := range numbers {
			if number[bit] == '1' {
				bit1 = append(bit1, number)
			} else {
				bit0 = append(bit0, number)
			}
		}

		var most, least []string
		if len(bit1) >= len(bit0) {
			most, least = bit1, bit0
		} else {
			most, least = bit0, bit1
		}

		if filterType == MostCommon {
			numbers = most
		} else {
			numbers = least
		}
	}
	n, _ := strconv.ParseInt(numbers[0], 2, 0)
	return int(n)
}
