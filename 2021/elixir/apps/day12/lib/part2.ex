defmodule Day12Part2 do
  @moduledoc """
  Day12 - Part2
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.reduce(%{}, fn [s | [e]], map ->
      map
      |> Map.update(s, [e], fn edges -> [e | edges] end)
      |> Map.update(e, [s], fn edges -> [s | edges] end)
    end)
    |> dfs()
    |> length()
  end

  defp dfs(map) do
    dfs("start", map, %{}, [], [])
  end

  defp dfs(node, _map, _visited, path, paths) when node == "end" do
    [
      Enum.reverse(["end" | path]) | paths
    ]
  end

  defp dfs(node, map, visited, path, paths) do
    if map[node] == nil or not can_visit?(node, visited) do
      # no path from here
      paths
    else
      visited =
        if(multi_visitable?(node), do: visited, else: Map.update(visited, node, 1, &(&1 + 1)))

      Enum.reduce(map[node], paths, fn next, paths ->
        dfs(next, map, visited, [node | path], paths)
      end)
    end
  end

  defp can_visit?(node, visited) do
    if node in ["start", "end"] do
      visited[node] == nil
    else
      visited[node] == nil or
        (visited[node] == 1 and Enum.all?(visited, fn {_k, v} -> v < 2 end))
    end
  end

  defp multi_visitable?(node) do
    String.upcase(node) == node
  end
end
