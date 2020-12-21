defmodule Day9 do
  def part_one(filename, preamble) do
    parse(filename)
    |> Enum.chunk_every(preamble + 1, 1, :discard)
    |> Enum.map(&List.pop_at(&1, -1))
    |> Enum.find_value(&breaks_sum_rule(&1))
  end

  defp parse(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp breaks_sum_rule({sum, list}) do
    sum_permutations =
      for i <- list, j <- list, into: [] do
        if i != j do
          i + j
        end
      end
      |> Enum.uniq()

    if !(sum_permutations |> Enum.member?(sum)) do
      sum
    end
  end

  def part_two(filename, preamble) do
    invalid_num = part_one(filename, preamble)

    parse(filename)
    |> Enum.filter(fn x -> x < invalid_num end)
    |> find_contiguous_set_of_nums(invalid_num)
  end

  defp find_contiguous_set_of_nums(list, invalid_num) do
    {acc, sub_list} =
      list
      |> Enum.reduce_while({0, []}, fn x, {acc, sub_list} ->
        if acc < invalid_num,
          do: {:cont, {acc + x, [x | sub_list]}},
          else: {:halt, {acc, sub_list}}
      end)

    if acc == invalid_num do
      Enum.min(sub_list) + Enum.max(sub_list)
    else
      find_contiguous_set_of_nums(tl(list), invalid_num)
    end
  end
end
