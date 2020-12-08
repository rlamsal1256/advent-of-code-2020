defmodule Day8Test do
  use ExUnit.Case

  test "1: example" do
    assert Day8.part_one("example.txt") == 5
  end

  test "1: input" do
    assert Day8.part_one("input.txt") == 1451
  end

  test "2: example" do
    assert Day8.part_two("example.txt") == 8
  end

  test "2: input" do
    assert Day8.part_two("input.txt") == 1160
  end
end
