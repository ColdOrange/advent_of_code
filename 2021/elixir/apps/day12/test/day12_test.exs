defmodule Day12Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day12", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day12Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day12", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day12Part2.solve(input) == output
    end)
  end
end
