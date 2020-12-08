defmodule Day6Test do
  use ExUnit.Case

  test "1: example" do
    assert Day6.part_one("example.txt") == 11
  end

  test "1: input" do
    assert Day6.part_one("input.txt") == 6457
  end

  test "2: example" do
    assert Day6.part_two("example.txt") == 6
  end

  test "2: input" do
    assert Day6.part_two("input.txt") == 3260
  end
end
