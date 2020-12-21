defmodule Day16Test do
  use ExUnit.Case

  # test "1: example" do
  #   assert Day16.p1("example.txt") == 71
  # end

  # test "1: input" do
  #   assert Day16.p1("input.txt") == 26009
  # end

  # test "2: example" do
  #   assert Day16.p2("example.txt") == 71
  # end

  # test "2: example twp" do
  #   assert Day16.p2("example_two.txt") == %{0 => ["row"], 1 => ["class"], 2 => ["seat"]}
  # end

  test "2: input" do
    assert Day16.p2("input.txt") == 589685618167
  end
end
