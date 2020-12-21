defmodule Day12Test do
  use ExUnit.Case

  test "1: example" do
    assert Day12.part_one("example.txt") == 25
  end

  test "1: input" do
    assert Day12.part_one("input.txt") == 879
  end

  test "2: example" do
    assert Day12.part_two("example.txt") == 286
  end

  test "2: input" do
    assert Day12.part_two("input.txt") == 18107
  end
end
