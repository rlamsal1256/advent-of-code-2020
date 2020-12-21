defmodule Day13 do
  def p1(filename) do
    [earliest_depart, bus_list] =
      File.read!(filename)
      |> String.split("\n", trim: true)

    earliest_depart = String.to_integer(earliest_depart) |> IO.inspect(label: "earliest_depart")

    {bus_id, wait_mins} =
      bus_list
      |> String.split(",", trim: true)
      |> Enum.filter(&(&1 != "x"))
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&find_nearest_timestamp(&1, earliest_depart, &1))
      |> Enum.min_by(fn {_x, y} -> y end)
      |> IO.inspect()

    bus_id * wait_mins
  end

  defp find_nearest_timestamp(bus_id, earliest_depart, new_bus_id) do
    if new_bus_id >= earliest_depart do
      {bus_id, new_bus_id - earliest_depart}
    else
      find_nearest_timestamp(bus_id, earliest_depart, new_bus_id + bus_id)
    end
  end

  def p2(filename) do
    parse_p2(filename)
    |> IO.inspect(label: "parsed")
    |> Enum.reduce(&find_earliest_timestamp/2)
    |> elem(0)
  end

  def parse_p2(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.at(1)
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.reject(fn {x, _} -> x == "x" end)
    |> Enum.map(fn {bus_id, i} -> {String.to_integer(bus_id), i} end)
  end

  def find_earliest_timestamp({bus_id, i} = curr, {timestamp, sync_time} = acc) do
    IO.inspect(curr, label: "curr")
    IO.inspect(acc, label: "acc")

    sync_time = if sync_time == 0, do: timestamp, else: sync_time

    offset_match =
      Stream.iterate(timestamp, &(&1 + sync_time))
      |> Enum.find(&(Integer.mod(&1 + i, bus_id) == 0))
      |> IO.inspect(label: "offset_match")

    IO.inspect(bus_id * sync_time, label: "new sync_time")
    {offset_match, bus_id * sync_time}
  end
end
