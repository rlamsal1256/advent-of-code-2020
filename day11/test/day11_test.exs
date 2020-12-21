defmodule Day11Test do
  use ExUnit.Case

  test "1: example" do
    assert Day11.part_one("example.txt") == 37
  end

  test "1: input" do
    assert Day11.part_one("input.txt") == 2273
  end

  test "2: example" do
    assert Day11.part_two("example.txt") == 26
  end

  test "2: input" do
    assert Day11.part_two("input.txt") == 2064
  end
end
