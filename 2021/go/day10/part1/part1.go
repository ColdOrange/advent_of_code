package part1

import (
	"bufio"
	"strconv"
	"strings"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	sum := 0
	for scanner.Scan() {
		parser := NewParser(scanner.Text())
		if parser.Parse() == Corrupted {
			sum += point(parser.FirstIllegal())
		}
	}
	return strconv.Itoa(sum)
}

func point(char byte) int {
	switch char {
	case ')':
		return 3
	case ']':
		return 57
	case '}':
		return 1197
	case '>':
		return 25137
	default:
		return 0
	}
}

type Parser struct {
	chunk string
	stack []byte
}

func NewParser(chunk string) *Parser {
	return &Parser{
		chunk: chunk,
	}
}

type ParseResult int

const (
	Ok ParseResult = iota
	Corrupted
	Incomplete
)

func (p *Parser) Parse() ParseResult {
	for len(p.chunk) != 0 {
		switch p.chunk[0] {
		// open
		case '[':
			p.stack = append(p.stack, ']')
		case '{':
			p.stack = append(p.stack, '}')
		case '(':
			p.stack = append(p.stack, ')')
		case '<':
			p.stack = append(p.stack, '>')

		// close
		default:
			l := len(p.stack)
			if l != 0 && p.stack[l-1] == p.chunk[0] {
				p.stack = p.stack[:l-1]
			} else {
				return Corrupted
			}
		}

		p.chunk = p.chunk[1:]
	}

	if len(p.stack) != 0 {
		return Incomplete
	}
	return Ok
}

func (p *Parser) FirstIllegal() byte {
	return p.chunk[0]
}

func (p *Parser) Completion() []byte {
	completion := make([]byte, len(p.stack))
	for i, char := range p.stack {
		completion[len(p.stack)-i-1] = char
	}
	return completion
}
