defmodule Day7Test do
  use ExUnit.Case

  test "1: example" do
    assert Day7.part_one("example.txt") == 4
  end

  test "1: input" do
    assert Day7.part_one("input.txt") == 226
  end

  test "2: example" do
    assert Day7.part_two("example.txt") == 32
  end

  test "2: example two" do
    assert Day7.part_two("example_two.txt") == 126
  end

  test "2: input" do
    assert Day7.part_two("input.txt") == 9569
  end
end
