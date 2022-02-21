package part1

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
	bits := len(numbers[0])
	gamma, epsilon, acc := 0, 0, 1
	for i := bits - 1; i >= 0; i-- {
		n1, n0 := 0, 0
		for _, number := range numbers {
			if number[i] == '1' {
				n1 += 1
			} else {
				n0 += 1
			}
		}

		if n1 > n0 {
			gamma += acc
		} else {
			epsilon += acc
		}
		acc *= 2
	}
	return gamma * epsilon
}
