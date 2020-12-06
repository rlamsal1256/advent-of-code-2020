defmodule Day5Test do
  use ExUnit.Case

  test "1: example" do
    {:ok, contents} = File.read("example.txt")
    contents =
      contents
      |> String.split("\n", trim: true)

    # assert Day5.part_one(contents) == [357, 567, 119, 820]
    assert Day5.part_one(contents) == 820
  end

  test "1: input" do
    {:ok, contents} = File.read("input.txt")
    contents =
      contents
      |> String.split("\n", trim: true)

    assert Day5.part_one(contents) == 906
  end

  test "2: input" do
    {:ok, contents} = File.read("input.txt")
    contents =
      contents
      |> String.split("\n", trim: true)

    assert Day5.part_two(contents) == 519
  end
end
