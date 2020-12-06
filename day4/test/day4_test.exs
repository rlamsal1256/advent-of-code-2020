defmodule Day4Test do
  use ExUnit.Case

  test "1: example" do
    {:ok, contents} = File.read("example.txt")

    contents =
      contents
      |> String.split("\n\n")

    assert Day4.part_one(contents) == 2
  end

  test "1: input" do
    {:ok, contents} = File.read("input.txt")

    contents =
      contents
      |> String.split("\n\n")

    assert Day4.part_one(contents) == 245
  end

  test "2: invalid passports" do
    {:ok, contents} = File.read("invalid.txt")

    contents =
      contents
      |> String.split("\n\n")

    assert Day4.part_two(contents) == 0
  end

  test "2: valid" do
    {:ok, contents} = File.read("valid.txt")

    contents =
      contents
      |> String.split("\n\n")

    assert Day4.part_two(contents) == 4
  end

  test "2: input" do
    {:ok, contents} = File.read("input.txt")

    contents =
      contents
      |> String.split("\n\n")

    assert Day4.part_two(contents) == 133
  end
end
