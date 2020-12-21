defmodule Day13Test do
  use ExUnit.Case

  test "1: example" do
    assert Day13.p1("example.txt") == 295
  end

  test "1: input" do
    assert Day13.p1("input.txt") == 136
  end

  test "2: example two" do
    assert Day13.p2("example_two.txt") == 3417
  end

  test "2: example three" do
    assert Day13.p2("example_three.txt") == 754018
  end

  test "2: example four" do
    assert Day13.p2("example_four.txt") == 779210
  end

  test "2: example five" do
    assert Day13.p2("example_five.txt") == 1261476
  end

  test "2: example six" do
    assert Day13.p2("example_six.txt") == 1202161486
  end

  test "2: example" do
    assert Day13.p2("example.txt") == 1068781
  end

  test "2: input" do
    assert Day13.p2("input.txt") == 305068317272992
  end
end
