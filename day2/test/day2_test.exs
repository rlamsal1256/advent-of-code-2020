defmodule Day2Test do
  use ExUnit.Case

  test "1: example" do
    {:ok, contents} = File.read("example.txt")
    entries = contents
      |> String.split("\n", trim: true)

    assert Day2.part_one(entries) == 2
  end

  test "1: input" do
    {:ok, contents} = File.read("input.txt")
    entries = contents
      |> String.split("\n", trim: true)

    assert Day2.part_one(entries) == 536
  end

  test "2: example" do
    {:ok, contents} = File.read("example.txt")
    entries = contents
      |> String.split("\n", trim: true)

    assert Day2.part_two(entries) == 1
  end

  test "2: input" do
    {:ok, contents} = File.read("input.txt")
    entries = contents
      |> String.split("\n", trim: true)

    assert Day2.part_two(entries) == 558
  end
end
