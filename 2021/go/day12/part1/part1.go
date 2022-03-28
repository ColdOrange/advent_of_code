package part1

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
	paths int
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
	g.paths = 0
	g.dfs("start", map[string]bool{})
	return g.paths
}

func (g *Graph) dfs(node string, visited map[string]bool) {
	if node == "end" {
		g.paths += 1
		return
	}

	visited[node] = true
	defer func() { visited[node] = false }()

	for _, next := range g.edges[node] {
		if !visited[next] || canVisitMultiTimes(next) {
			g.dfs(next, visited)
		}
	}
}

func canVisitMultiTimes(node string) bool {
	return strings.ToUpper(node) == node
}
