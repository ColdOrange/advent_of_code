package part2

import (
	"bufio"
	"strconv"
	"strings"
)

func Solve(input string) string {
	scanner := bufio.NewScanner(strings.NewReader(input))
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return strconv.Itoa(NewGraph(lines).DFS())
}

type Graph struct {
	edges map[string][]string
}

func NewGraph(lines []string) *Graph {
	edges := make(map[string][]string)
	for _, line := range lines {
		s := strings.Split(line, "-")
		n1, n2 := s[0], s[1]
		edges[n1] = append(edges[n1], n2)
		edges[n2] = append(edges[n2], n1)
	}
	return &Graph{edges: edges}
}

func (g *Graph) DFS() int {
	return g.dfs("start", map[string]int{})
}

func (g *Graph) dfs(node string, visited map[string]int) int {
	if node == "end" {
		return 1
	}

	visited[node] += 1
	defer func() { visited[node] -= 1 }()

	paths := 0
	for _, next := range g.edges[node] {
		if visited[next] == 0 || canVisitMultiTimes(next) || canVisitTwice(next, visited) {
			paths += g.dfs(next, visited)
		}
	}
	return paths
}

func canVisitMultiTimes(node string) bool {
	return strings.ToUpper(node) == node
}

func canVisitTwice(node string, visited map[string]int) bool {
	if node == "start" || node == "end" || visited[node] > 1 {
		return false
	}
	for n, c := range visited {
		if c > 1 && !canVisitMultiTimes(n) {
			return false
		}
	}
	return true
}
