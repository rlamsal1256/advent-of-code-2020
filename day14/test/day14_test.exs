defmodule Day14Test do
  use ExUnit.Case

  test "1: example" do
    assert Day14.p1("example.txt") == 165
  end

  test "1: input" do
    assert Day14.p1("input.txt") == 13105044880745
  end

  test "2: example" do
    assert Day14.p2("example_two.txt")== 208
  end

  test "2: input" do
    assert Day14.p2("input.txt") == 3505392154485
  end
end
