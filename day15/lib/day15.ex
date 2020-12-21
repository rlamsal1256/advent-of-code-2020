defmodule Day15 do
  def p1(list, end_index) do
    map =
      list
      |> Enum.with_index(1)
      |> Enum.into(%{})

    turn = map_size(map) + 1
    last_value = List.last(list)
    loop(map, turn, last_value, end_index)
  end

  defp loop(_map, turn, last_value, end_index) when turn == end_index + 1, do: last_value

  defp loop(map, turn, last_value, end_index) do
    previous_turn = turn - 1

    new_number =
      case Map.get(map, last_value) do
        nil -> 0
        i -> previous_turn - i
      end

    new_map = Map.put(map, last_value, previous_turn)
    loop(new_map, turn + 1, new_number, end_index)
  end
end
