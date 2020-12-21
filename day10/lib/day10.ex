defmodule Day10 do
  def part_one(filename) do
    jolt_diff =
      filename
      |> parse()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [x, y] -> y - x end)
      |> IO.inspect(label: "jolt_diff")

    count(jolt_diff, 1) * count(jolt_diff, 3)
  end

  defp parse(filename) do
    input =
      File.read!(filename)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
      |> IO.inspect(label: "input")

    outlet = [0 | input] |> IO.inspect(label: "outlet")
    (outlet ++ [List.last(outlet) + 3]) |> IO.inspect(label: "adapter")
  end

  defp count(list, num) do
    list
    |> Enum.filter(&(&1 == num))
    |> Enum.count()
  end

  def part_two(filename) do
    [0 | [hd | tl]] =
      filename
      |> parse()

    chunk(hd, tl, [], [0])
    |> Enum.filter(fn x -> length(x) > 1 end)
    |> IO.inspect()
    |> Enum.map(&(trib(length(&1))))
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  defp chunk(_, [], list, _), do: list

  defp chunk(x, [hd | tl], list, sub_list) do
    if x + 1 == hd do
      chunk(hd, tl, list, [hd | sub_list])
    else
      chunk(hd, tl, [sub_list | list], [])
    end
  end

  defp trib(0), do: 1
  defp trib(1), do: 1
  defp trib(2), do: 2

  defp trib(num) do
    trib(num - 1) + trib(num - 2) + trib(num - 3)
  end
end
