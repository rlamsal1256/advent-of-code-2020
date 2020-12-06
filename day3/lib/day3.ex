defmodule Day3 do
  def part_one(contents, right) do
    contents
    |> Enum.map(&repeat(&1, Enum.count(contents)))
    |> Enum.with_index()
    |> Enum.count(&is_tree(&1, right))
  end

  def part_two(contents, right, down) do
    contents
    |> Enum.map(&repeat(&1, Enum.count(contents)))
    |> Enum.take_every(down)
    |> Enum.with_index()
    |> Enum.count(&is_tree(&1, right))
  end

  defp repeat(content, count) do
    Enum.reduce(0..count, "", fn _, acc ->
      content <> acc
    end)
  end

  defp is_tree({content, index}, right) do
    String.at(content, right * index) == "#"
  end
end
