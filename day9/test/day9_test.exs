defmodule Day9Test do
  use ExUnit.Case

  test "1: example" do
    assert Day9.part_one("example.txt", _preamble = 5) == 127
  end

  test "1: input" do
    assert Day9.part_one("input.txt", _preamble = 25) == 26796446
  end

  test "2: example" do
    assert Day9.part_two("example.txt", _preamble = 5) == 62
  end

  test "2: input" do
    assert Day9.part_two("input.txt", _preamble = 25) == 3353494
  end
end
