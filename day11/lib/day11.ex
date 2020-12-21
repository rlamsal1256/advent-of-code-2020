defmodule Day11 do
  def part_one(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> exec(&seating_rules/2)
  end

  defp exec(layout, func) do
    change_layout = fn layout ->
      layout
      |> Enum.with_index()
      |> Enum.map(fn {row, r} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {_, c} ->
          func.(layout, [r, c])
        end)
      end)
    end

    loop_until_stable([], layout, change_layout)
    |> List.flatten()
    |> Enum.count(&(&1 == "#"))
  end

  defp loop_until_stable(prev, new, func) do
    if Enum.sort(prev) == Enum.sort(new) do
      prev
    else
      loop_until_stable(new, func.(new), func)
    end
  end

  defp seating_rules(layout, [r, c]) do
    occupied_seats_count =
      [
        count_adjacent_seat(layout, [r - 1, c - 1]),
        count_adjacent_seat(layout, [r - 1, c]),
        count_adjacent_seat(layout, [r - 1, c + 1]),
        count_adjacent_seat(layout, [r, c + 1]),
        count_adjacent_seat(layout, [r + 1, c + 1]),
        count_adjacent_seat(layout, [r + 1, c]),
        count_adjacent_seat(layout, [r + 1, c - 1]),
        count_adjacent_seat(layout, [r, c - 1])
      ]
      |> Enum.sum()

    seat = layout |> Enum.at(r) |> Enum.at(c)

    case {seat, occupied_seats_count} do
      {"L", 0} -> "#"
      {"#", x} when x >= 4 -> "L"
      _ -> seat
    end
  end

  defp count_adjacent_seat(layout, [row, col]) do
    max_row = layout |> length()
    max_col = layout |> List.first() |> length()

    cond do
      row < 0 -> 0
      col < 0 -> 0
      row >= max_row -> 0
      col >= max_col -> 0
      true -> if layout |> Enum.at(row) |> Enum.at(col) == "#", do: 1, else: 0
    end
  end

  def part_two(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> exec(&change_layout_using_visible_adjacent_seats/2)
  end

  def change_layout_using_visible_adjacent_seats(layout, [r, c]) do
    occupied_seats_count =
      [
        count_visible_adjacent_seat(layout, "N", [r - 1, c]),
        count_visible_adjacent_seat(layout, "NE", [r - 1, c + 1]),
        count_visible_adjacent_seat(layout, "E", [r, c + 1]),
        count_visible_adjacent_seat(layout, "SE", [r + 1, c + 1]),
        count_visible_adjacent_seat(layout, "S", [r + 1, c]),
        count_visible_adjacent_seat(layout, "SW", [r + 1, c - 1]),
        count_visible_adjacent_seat(layout, "W", [r, c - 1]),
        count_visible_adjacent_seat(layout, "NW", [r - 1, c - 1])
      ]
      |> Enum.sum()

    seat = layout |> Enum.at(r) |> Enum.at(c)

    case {seat, occupied_seats_count} do
      {"L", 0} -> "#"
      {"#", x} when x >= 5 -> "L"
      _ -> seat
    end
  end

  defp count_visible_adjacent_seat(layout, dir, [r, c]) do
    max_row = layout |> length()
    max_col = layout |> List.first() |> length()

    cond do
      r < 0 ->
        0

      c < 0 ->
        0

      r >= max_row ->
        0

      c >= max_col ->
        0

      true ->
        value = layout |> Enum.at(r) |> Enum.at(c)

        case value do
          "." -> count_visible_adjacent_seat(layout, dir, next(dir, r, c))
          "L" -> 0
          "#" -> 1
        end
    end
  end

  defp next(dir, r, c) do
    case dir do
      "N" -> [r - 1, c]
      "NE" -> [r - 1, c + 1]
      "E" -> [r, c + 1]
      "SE" -> [r + 1, c + 1]
      "S" -> [r + 1, c]
      "SW" -> [r + 1, c - 1]
      "W" -> [r, c - 1]
      "NW" -> [r - 1, c - 1]
    end
  end
end
