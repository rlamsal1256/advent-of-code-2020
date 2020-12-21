defmodule Day16 do
  def p1(filename) do
    [valid_ranges, _, nearby_tickets] =
      File.read!(filename)
      |> String.split("\n\n", trim: true)

    valid_ranges =
      valid_ranges
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [x1, x2, y1, y2] =
          Regex.run(~r/.*: (\d+)-(\d+) or (\d+)-(\d+)/, line, capture: :all_but_first)

        Enum.to_list(String.to_integer(x1)..String.to_integer(x2)) ++
          Enum.to_list(String.to_integer(y1)..String.to_integer(y2))
      end)
      |> List.flatten()

    nearby_tickets
    |> String.replace("nearby tickets:\n", "")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.filter(fn num ->
        !Enum.member?(valid_ranges, num)
      end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def p2(filename) do
    [valid_ranges, ticket, nearby_tickets] =
      File.read!(filename)
      |> String.split("\n\n", trim: true)

    valid_ranges =
      valid_ranges
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn line, acc ->
        [field, x1, x2, y1, y2] =
          Regex.run(~r/(.*): (\d+)-(\d+) or (\d+)-(\d+)/, line, capture: :all_but_first)

        list =
          Enum.to_list(String.to_integer(x1)..String.to_integer(x2)) ++
            Enum.to_list(String.to_integer(y1)..String.to_integer(y2))

        Map.put(acc, field, list)
      end)

    ticket =
      ticket
      |> String.split("\n")
      |> List.last()
      |> String.split(",")

    nearby_valid_tickets =
      nearby_tickets
      |> String.replace("nearby tickets:\n", "")
      |> String.split("\n", trim: true)
      |> Enum.filter(fn line ->
        line
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> Enum.filter(fn num ->
          valid_range_list = valid_ranges |> Map.values() |> List.flatten()
          !Enum.member?(valid_range_list, num)
        end) == []
      end)

    init_map =
      Enum.reduce(0..(length(ticket) - 1), %{}, fn i, acc ->
        Map.put(acc, i, valid_ranges |> Map.keys())
      end)

    nearby_valid_tickets
    |> Enum.reduce(init_map, &discard_invalid_tickets(&1, &2, valid_ranges))
    |> determine_field_order
    |> multiply_all_departures(ticket)
  end

  defp discard_invalid_tickets(nearby_ticket, map, valid_ranges) do
    discard_map =
      nearby_ticket
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {v, i}, acc ->
        not_possible_fields =
          valid_ranges
          |> Map.keys()
          |> Enum.filter(fn k ->
            !Enum.member?(valid_ranges[k], v)
          end)

        Map.put(acc, i, not_possible_fields)
      end)

    map
    |> Map.keys()
    |> Enum.reduce(map, fn k, acc ->
      value = Map.get(acc, k) -- Map.get(discard_map, k)
      Map.put(acc, k, value)
    end)
  end

  defp determine_field_order(map), do: determine_field_order(map, %{})

  defp determine_field_order(map, determined_so_far) do
    if field_determined(map) do
      map
    else
      determined =
        map
        |> Enum.filter(fn {_, y} ->
          length(y) == 1
        end)
        |> Enum.into(%{})

      newly_determined = diff(determined, determined_so_far)

      new_map =
        map
        |> Enum.reduce(map, fn {i, possible_fields}, x ->
          udpated_map =
            newly_determined
            |> Enum.reduce(%{}, fn {j, certain_fields}, _ ->
              if i != j do
                new_field = possible_fields -- certain_fields
                Map.put(x, i, new_field)
              else
                Map.put(x, i, certain_fields)
              end
            end)

          Map.put(x, i, udpated_map[i])
        end)
        |> Enum.into(%{})

      determine_field_order(new_map, determined)
    end
  end

  defp field_determined(map) do
    map
    |> Enum.all?(fn {_i, fields} -> length(fields) == 1 end)
  end

  defp diff(new_map, old_map) do
    new_map
    |> Enum.filter(fn {k, _v} ->
      !Map.has_key?(old_map, k)
    end)
    |> Enum.into(%{})
  end

  defp multiply_all_departures(map, ticket) do
    map
    |> Enum.filter(fn {_, [field]} ->
      String.contains?(field, "departure")
    end)
    |> Enum.map(fn {i, _} -> i end)
    |> Enum.reduce(1, fn i, acc ->
      acc * (Enum.at(ticket, i) |> String.to_integer())
    end)
  end
end
