package part2

import (
	"bufio"
	"strconv"
	"strings"
)

type Board struct {
	numbers []int
	marked  []bool
}

func (b *Board) mark(number int) {
	for i, n := range b.numbers {
		if n == number {
			b.marked[i] = true
		}
	}
}

func (b *Board) win() bool {
	for i := 0; i < 5; i++ {
		if b.marked[i*5] && b.marked[i*5+1] && b.marked[i*5+2] && b.marked[i*5+3] && b.marked[i*5+4] ||
			b.marked[i] && b.marked[5+i] && b.marked[10+i] && b.marked[15+i] && b.marked[20+i] {
			return true
		}
	}
	return false
}

func (b *Board) sum() int {
	sum := 0
	for i, n := range b.numbers {
		if !b.marked[i] {
			sum += n
		}
	}
	return sum
}

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))

	var draws []int
	scanner.Scan()
	for _, s := range strings.Split(scanner.Text(), ",") {
		n, _ := strconv.Atoi(s)
		draws = append(draws, n)
	}

	var boards []*Board
	var numbers []int
	for scanner.Scan() {
		for _, s := range strings.Fields(scanner.Text()) {
			n, _ := strconv.Atoi(s)
			numbers = append(numbers, n)
		}
		if len(numbers) == 25 {
			boards = append(boards, &Board{
				numbers: numbers,
				marked:  make([]bool, 25),
			})
			numbers = nil
		}
	}

	return strconv.Itoa(calc(draws, boards))
}

func calc(draws []int, boards []*Board) int {
	var last int
	for _, draw := range draws {
		for _, board := range boards {
			if board.win() {
				continue
			}

			board.mark(draw)
			if board.win() {
				last = board.sum() * draw
			}
		}
	}
	return last
}
