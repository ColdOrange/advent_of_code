defmodule TestDataTest do
  use ExUnit.Case
  doctest TestData

  test "ok" do
    TestData.get("day1", "part1")
    |> Enum.each(fn test_case ->
      assert %{"input" => _, "output" => _} = test_case
    end)
  end

  test "raise" do
    assert_raise RuntimeError, ~r/Read test data "day1\/not_exist.yaml" failed/, fn ->
      TestData.get("day1", "not_exist")
    end
  end
end
