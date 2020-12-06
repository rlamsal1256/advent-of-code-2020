defmodule Day1Test do
  use ExUnit.Case

  test "part one: example" do
    {:ok, contents} = File.read("example.txt")
    entries = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
    assert Day1.part_one(entries) == 514579
  end

  test "part one: find the two entries that sum to 2020 and then multiply those two numbers together" do
    {:ok, contents} = File.read("input.txt")
    entries = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
    assert Day1.part_one(entries) == 712075
  end


  test "part two: example" do
    {:ok, contents} = File.read("example.txt")
    entries = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
    assert Day1.part_two(entries) == 241861950
  end

  test "part two: product of the three entries that sum to 2020" do
    {:ok, contents} = File.read("input.txt")
    entries = contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
    assert Day1.part_two(entries) == 145245270
  end
end
