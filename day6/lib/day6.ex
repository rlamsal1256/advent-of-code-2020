defmodule Day6 do
  def part_one(filename) do
    {:ok, contents} = File.read(filename)

    contents
    |> String.split("\n\n")
    |> Enum.map(&calculate_unique_answers/1)
    |> Enum.sum()
  end

  defp calculate_unique_answers(group_answer) do
    group_answer
    |> String.replace("\n", "")
    |> String.graphemes()
    |> Enum.uniq()
    |> Enum.count()
  end

  def part_two(filename) do
    {:ok, contents} = File.read(filename)

    contents
    |> String.split("\n\n")
    |> Enum.map(&calculate_common_answers/1)
    |> Enum.sum()
  end

  defp calculate_common_answers(group_answer) do
    individual_answers =
      group_answer
      |> String.split("\n", trim: true)

    List.first(individual_answers)
    |> String.graphemes()
    |> Enum.count(fn first_answer ->
      Enum.all?(individual_answers, fn individual_answer ->
        String.contains?(individual_answer, first_answer)
      end)
    end)
  end
end
