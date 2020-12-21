defmodule Day15Test do
  use ExUnit.Case

  test "1: examples" do
    assert Day15.p1([0, 3, 6], 2020) == 436
    assert Day15.p1([1, 3, 2], 2020) == 1
    assert Day15.p1([2, 1, 3], 2020) == 10
    assert Day15.p1([1, 2, 3], 2020) == 27
    assert Day15.p1([2, 3, 1], 2020) == 78
    assert Day15.p1([3, 2, 1], 2020) == 438
    assert Day15.p1([3, 1, 2], 2020) == 1836
  end

  test "1: input" do
    assert Day15.p1([11,18,0,20,1,7,16], 2020) == 639
  end

  test "2: examples" do
    assert Day15.p1([0,3,6], 30000000) == 175594
    assert Day15.p1([1, 3, 2], 30000000) == 2578
    assert Day15.p1([2, 1, 3], 30000000) == 3544142
    assert Day15.p1([1, 2, 3], 30000000) == 261214
    assert Day15.p1([2, 3, 1], 30000000) == 6895259
    assert Day15.p1([3, 2, 1], 30000000) == 18
    assert Day15.p1([3, 1, 2], 30000000) == 362
  end

  test "2: input" do
    assert Day15.p1([11,18,0,20,1,7,16], 30000000) == 266
  end

end
