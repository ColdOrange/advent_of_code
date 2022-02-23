package part2

import (
	"bufio"
	"fmt"
	"strconv"
	"strings"
)

type Point struct {
	x, y int
}

type Points map[Point]int

func (ps Points) addPoints(x1, y1, x2, y2 int) {
	if x1 == x2 {
		for y := min(y1, y2); y <= max(y1, y2); y++ {
			ps.addPoint(x1, y)
		}
	} else if y1 == y2 {
		for x := min(x1, x2); x <= max(x1, x2); x++ {
			ps.addPoint(x, y1)
		}
	} else if x1+y1 == x2+y2 {
		for x := min(x1, x2); x <= max(x1, x2); x++ {
			ps.addPoint(x, x1+y1-x)
		}
	} else if x1-y1 == x2-y2 {
		for x := min(x1, x2); x <= max(x1, x2); x++ {
			ps.addPoint(x, y1-x1+x)
		}
	}
}

func (ps Points) addPoint(x, y int) {
	point := Point{x: x, y: y}
	if count, exist := ps[point]; exist {
		ps[point] = count + 1
	} else {
		ps[point] = 1
	}
}

func (ps Points) count() int {
	n := 0
	for _, count := range ps {
		if count >= 2 {
			n += 1
		}
	}
	return n
}

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var x1, y1, x2, y2 int
	points := make(Points)
	for scanner.Scan() {
		_, _ = fmt.Sscanf(scanner.Text(), "%d,%d -> %d,%d", &x1, &y1, &x2, &y2)
		points.addPoints(x1, y1, x2, y2)
	}
	return strconv.Itoa(points.count())
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
