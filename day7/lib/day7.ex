defmodule Day7 do

  def part_one(file_name) do
    parse(file_name)
    |> count_gold()
  end

  defp parse(file_name) do
    {:ok, file_contents} = File.read(file_name)

    file_contents
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(
      &Regex.run(~r/^(\w+ \w+) bags contain( no other bags.|(?> \d \w+ \w+ bags?(?>\.|,))+)/, &1,
        capture: :all_but_first
      )
    )
    |> Enum.map(fn [hd, tl] -> {hd, parse_children(tl)} end)
    |> Map.new()
    |> IO.inspect()
  end

  defp parse_children(" no other bags."), do: %{}

  defp parse_children(str) do
    str
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&Regex.run(~r/ ?(\d) (\w+ \w+) bags?.?/, &1, capture: :all_but_first))
    |> Enum.map(fn [i, n] -> {n, String.to_integer(i)} end)
    |> Map.new()
  end

  def count_gold(map) do
    map
    |> Map.keys()
    |> Enum.count(
      &contains_gold(
        map,
        map |> Map.get(&1) |> Map.keys()
      )
    )
  end

  defp contains_gold(_map, []) do
    false
  end

  defp contains_gold(map, contents) do
    if contents |> Enum.member?("shiny gold") do
      true
    else
      contents
      |> Enum.any?(&contains_gold(map, map |> Map.get(&1) |> Map.keys()))
    end
  end


  def part_two(file_name) do
    parse(file_name)
    |> count_bags_inside_gold_bag()
  end

  defp count_bags_inside_gold_bag(map) do
    map
    |> Map.get("shiny gold")
    |> Enum.map(&count_bags(map, &1))
    |> Enum.sum()
  end

  defp count_bags(map, {key, value}) do
    value + value * count(map, key)
  end

  defp count(map, key) do
    map
    |> Map.get(key)
    |> Enum.map(&count_bags(map, &1))
    |> Enum.sum()
  end
end
