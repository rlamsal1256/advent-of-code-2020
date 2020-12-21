defmodule Day19Test do
  use ExUnit.Case

  test "1: example" do
    assert Day19.p1("example.txt") == 2
      # ["aaaabb", "abbabb", "aaabab", "abbbab", "aabaab", "abaaab", "aabbbb", "ababbb"]
  end

  test "1: input" do
    assert Day19.p1("input.txt") == 115
  end

  test "2: example two" do
    assert Day19.p2("example_two.txt") == 12
  end

  test "2: input" do
    assert Day19.p2("input.txt") == 237
  end
end
