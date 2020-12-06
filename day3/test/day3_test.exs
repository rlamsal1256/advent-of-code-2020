defmodule Day3Test do
  use ExUnit.Case

  test "1: example" do
    {:ok, contents} = File.read("example.txt")

    contents =
      contents
      |> String.split("\n", trim: true)

    assert Day3.part_one(contents, 3) == 7
  end

  test "1: input" do
    {:ok, contents} = File.read("input.txt")

    contents =
      contents
      |> String.split("\n", trim: true)

    assert Day3.part_one(contents, 3) == 294
  end

  test "2: example" do
    {:ok, contents} = File.read("example.txt")

    contents =
      contents
      |> String.split("\n", trim: true)

    assert Day3.part_two(contents, 1, 1) == 2
    assert Day3.part_two(contents, 3, 1) == 7
    assert Day3.part_two(contents, 5, 1) == 3
    assert Day3.part_two(contents, 7, 1) == 4
    assert Day3.part_two(contents, 1, 2) == 2

    assert Day3.part_two(contents, 1, 1) *
             Day3.part_two(contents, 3, 1) *
             Day3.part_two(contents, 5, 1) *
             Day3.part_two(contents, 7, 1) *
             Day3.part_two(contents, 1, 2) ==
              336
  end

  test "2: input" do
    {:ok, contents} = File.read("input.txt")

    contents =
      contents
      |> String.split("\n", trim: true)

    assert Day3.part_two(contents, 1, 1) == 75
    assert Day3.part_two(contents, 3, 1) == 294
    assert Day3.part_two(contents, 5, 1) == 79
    assert Day3.part_two(contents, 7, 1) == 85
    assert Day3.part_two(contents, 1, 2) == 39

    assert Day3.part_two(contents, 1, 1) *
             Day3.part_two(contents, 3, 1) *
             Day3.part_two(contents, 5, 1) *
             Day3.part_two(contents, 7, 1) *
             Day3.part_two(contents, 1, 2) ==
             5_774_564_250
  end
end
