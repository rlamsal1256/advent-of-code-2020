defmodule Day17 do
  def p1(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> find_all_active_cubes()
    |> IO.inspect(label: "active_set")
    |> Enum.map(fn {x, y} -> {x, y, 0} end)
    |> loop(6)
    |> Enum.count()
  end

  def p2(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> find_all_active_cubes()
    |> Enum.map(fn {x, y} -> {x, y, 0, 0} end)
    |> loop(6)
    |> Enum.count()
  end

  def find_all_active_cubes(input) do
    input
    |> Enum.map(&String.graphemes/1)
    |> Enum.with_index()
    |> Enum.reduce([], fn {row, y}, acc ->
      row
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, x}, acc ->
        case value do
          "#" -> [{x, y} | acc]
          _ -> acc
        end
      end)
    end)
  end

  def loop(active_set, 0), do: active_set

  def loop(active_set, n) do
    new_state =
      active_set
      |> Enum.map(&get_neighbours/1)
      |> List.flatten()
      |> MapSet.new()
      |> Enum.filter(&newly_active(&1, active_set))
      |> MapSet.new()
      |> IO.inspect(label: "new state")

    loop(new_state, n - 1)
  end

  defp newly_active(coord, active_set) do
    case {coord in active_set, active_neighbours_count(coord, active_set)} do
      {true, 2} -> true
      {true, 3} -> true
      {false, 3} -> true
      _ -> false
    end
  end

  def get_neighbours({x, y, z}) do
    for nx <- (x - 1)..(x + 1),
        ny <- (y - 1)..(y + 1),
        nz <- (z - 1)..(z + 1),
        {x, y, z} != {nx, ny, nz} do
      {nx, ny, nz}
    end
  end

  def get_neighbours({x, y, z, w}) do
    for nx <- (x - 1)..(x + 1),
        ny <- (y - 1)..(y + 1),
        nz <- (z - 1)..(z + 1),
        nw <- (w - 1)..(w + 1),
        {x, y, z, w} != {nx, ny, nz, nw} do
      {nx, ny, nz, nw}
    end
  end

  def active_neighbours_count(coord, active_set) do
    coord
    |> get_neighbours()
    |> Enum.filter(fn neighbor -> neighbor in active_set end)
    |> Enum.count()
  end
end
