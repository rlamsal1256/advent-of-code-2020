defmodule Day5 do
  def part_one(contents) do
    contents
    |> Enum.map(&unique_seat_id/1)
    |> Enum.max()
  end

  defp unique_seat_id(seat_code) do
    {row_code, column_code} = String.split_at(seat_code, 7)
    get_row(row_code) * 8 + get_column(column_code)
  end

  defp get_row(code) do
    chars = String.graphemes(code)
    chars
    |> Enum.reduce({0, 127}, &parse_row/2)
  end

  defp parse_row(char, {min, max}) when max - min == 1 do
    case char do
      "F" -> min
      "B" -> max
    end
  end

  defp parse_row(char, {min, max}) do
    case char do
      "F" -> {min, min + div(max-min, 2)}
      "B" -> {min + ceil((max-min)/2), max}
    end
  end

  defp get_column(code) do
    chars = String.graphemes(code)
    chars
    |> Enum.reduce({0, 7}, &parse_column/2)
  end

  defp parse_column(char, {min, max}) when max - min == 1 do
    case char do
      "L" -> min
      "R" -> max
    end
  end

  defp parse_column(char, {min, max}) do
    case char do
      "L" -> {min, min + div(max-min, 2)}
      "R" -> {min + ceil((max-min)/2), max}
    end
  end

  def part_two(contents) do
    seat_ids = contents
    |> Enum.map(&unique_seat_id/1)
    |> Enum.sort()

    start = seat_ids |> List.first()
    last = seat_ids |> List.last()

    idx = Enum.find(start+1..last, fn x ->
      Enum.at(seat_ids, x) - 1 != Enum.at(seat_ids, x - 1)
    end)

    Enum.at(seat_ids, idx) - 1
  end
end
