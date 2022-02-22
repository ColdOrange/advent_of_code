defmodule Day4Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day4", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day4Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day4", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day4Part2.solve(input) == output
    end)
  end
end
