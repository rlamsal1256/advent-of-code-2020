defmodule Day10Test do
  use ExUnit.Case

  test "1: example" do
    assert Day10.part_one("example.txt") == 35
  end

  test "1: example two" do
    assert Day10.part_one("example_two.txt") == 220
  end

  test "1: input" do
    assert Day10.part_one("input.txt") == 2482
  end

  test "2: example" do
    assert Day10.part_two("example.txt") == 8
  end

  test "2: example two" do
    assert Day10.part_two("example_two.txt") == 19208
  end

  test "2: input" do
    assert Day10.part_two("input.txt") == 96717311574016
  end
end
