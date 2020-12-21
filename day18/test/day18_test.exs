defmodule Day18Test do
  use ExUnit.Case

  test "1: example" do
    assert Day18.p1("example.txt") == 26457
  end

  test "1: input" do
    assert Day18.p1("input.txt") == 7293529867931
  end

  test "2: example" do
    assert Day18.p2("example.txt") == 694173
  end

  test "2: input" do
    assert Day18.p2("input.txt") == 60807587180737
  end
end
