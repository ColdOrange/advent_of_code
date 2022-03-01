defmodule Day8Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day8", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day8Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day8", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day8Part2.solve(input) == output
    end)
  end
end
