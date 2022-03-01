package part2

import (
	"bufio"
	"strconv"
	"strings"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	sum := 0
	for scanner.Scan() {
		s := strings.Split(scanner.Text(), " | ")
		patterns, numbers := strings.Split(s[0], " "), strings.Split(s[1], " ")
		sum += calc(patterns, numbers)
	}
	return strconv.Itoa(sum)
}

func calc(patterns []string, numbers []string) int {
	result := 0
	for _, n := range ParseNumbers(patterns, numbers) {
		result = result*10 + n
	}
	return result
}

func ParseNumbers(patterns []string, numbers []string) []int {
	charMapping := charMapping(patterns)

	var parsedNumbers []int
	for _, number := range numbers {
		for pattern, value := range goodPatterns {
			if match(pattern, number, charMapping) {
				parsedNumbers = append(parsedNumbers, value)
			}
		}
	}
	return parsedNumbers
}

var goodPatterns = map[string]int{
	"abcefg":  0,
	"cf":      1,
	"acdeg":   2,
	"acdfg":   3,
	"bcdf":    4,
	"abdfg":   5,
	"abdefg":  6,
	"acf":     7,
	"abcdefg": 8,
	"abcdfg":  9,
}

func match(goodPattern, badPattern string, charMapping map[rune]rune) bool {
	if len(goodPattern) != len(badPattern) {
		return false
	}
	for _, char := range goodPattern {
		if !strings.ContainsRune(badPattern, charMapping[char]) {
			return false
		}
	}
	return true
}

func charMapping(patterns []string) map[rune]rune {
	var a, b, c, d, e, f, g rune
	for char, frequency := range charFrequencies(patterns) {
		switch frequency {
		case 4:
			e = char
		case 6:
			b = char
		case 9:
			f = char
		}
	}

	cf := filter(patterns, func(s string) bool { return len(s) == 2 })
	c = mask(cf, f)

	acf := filter(patterns, func(s string) bool { return len(s) == 3 })
	a = mask(acf, c, f)

	bcdf := filter(patterns, func(s string) bool { return len(s) == 4 })
	d = mask(bcdf, b, c, f)

	abcdefg := filter(patterns, func(s string) bool { return len(s) == 7 })
	g = mask(abcdefg, a, b, c, d, e, f)

	return map[rune]rune{
		'a': a,
		'b': b,
		'c': c,
		'd': d,
		'e': e,
		'f': f,
		'g': g,
	}
}

func charFrequencies(patterns []string) map[rune]int {
	frequencies := make(map[rune]int)
	for _, pattern := range patterns {
		for _, char := range pattern {
			frequencies[char] += 1
		}
	}
	return frequencies
}

func filter(patterns []string, fn func(string) bool) string {
	for _, pattern := range patterns {
		if fn(pattern) {
			return pattern
		}
	}
	return ""
}

func mask(str string, chars ...rune) rune {
	for _, char := range str {
		if !strings.ContainsRune(string(chars), char) {
			return char
		}
	}
	return 0
}
