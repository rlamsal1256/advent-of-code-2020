defmodule Day1 do
  def part_one(entries) do
    entries
    |> Enum.filter(&find_matching_entry(entries, &1))
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def find_matching_entry(entries, entry) do
    Enum.find(entries, fn matching_entry ->
      2020 - matching_entry == entry
    end)
  end

  def part_two(entries) do
    entries
    |> Enum.filter(&find_second_matching_entry(entries, &1))
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def find_second_matching_entry(entries, first_entry) do
    entries
    |> Enum.find(&find_matching_entry(entries, &1 + first_entry))
  end
end
