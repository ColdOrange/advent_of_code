package part2

import (
	"bufio"
	"strconv"
	"strings"
)

type Command struct {
	Operation string
	Value     int
}

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var commands []*Command
	for scanner.Scan() {
		s := strings.Split(scanner.Text(), " ")
		v, _ := strconv.Atoi(s[1])
		commands = append(commands, &Command{
			Operation: s[0],
			Value:     v,
		})
	}
	return strconv.Itoa(dive(commands))
}

func dive(commands []*Command) int {
	horizontal, depth, aim := 0, 0, 0
	for _, c := range commands {
		switch c.Operation {
		case "forward":
			horizontal += c.Value
			depth += c.Value * aim
		case "up":
			aim -= c.Value
		case "down":
			aim += c.Value
		}
	}
	return horizontal * depth
}
