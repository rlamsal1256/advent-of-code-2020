defmodule Day12 do
  def part_one(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.reduce({0, 0, "E"}, &navigate/2)
    |> calc_distance()
  end

  defp navigate(instruction, {n, e, dir}) do
    {action, value} = instruction |> String.split_at(1)
    value = value |> String.to_integer()

    case action do
      "N" -> {n + value, e, dir}
      "S" -> {n - value, e, dir}
      "E" -> {n, e + value, dir}
      "W" -> {n, e - value, dir}
      "L" -> turn(n, e, dir, value, &subtract/2)
      "R" -> turn(n, e, dir, value, &add/2)
      "F" -> forward(n, e, dir, value)
    end
  end

  defp add(a, b), do: a + b
  defp subtract(a, b), do: a - b

  defp turn(n, e, dir, value, func) do
    dir_order = ["N", "E", "S", "W"]
    times = div(value, 90)
    cur_index = Enum.find_index(dir_order, fn x -> x == dir end)
    new_idx = rem(func.(cur_index, times), 4)

    new_dir = Enum.at(dir_order, new_idx)

    {n, e, new_dir}
  end

  defp forward(n, e, dir, value) do
    case dir do
      "N" -> {n + value, e, dir}
      "S" -> {n - value, e, dir}
      "E" -> {n, e + value, dir}
      "W" -> {n, e - value, dir}
    end
  end

  defp calc_distance({n, e, _}) do
    abs(n) + abs(e)
  end

  defp calc_distance({w_e, w_n, _, _}) do
    abs(w_e) + abs(w_n)
  end

  def part_two(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.reduce({0, 0, 10, 1}, &navigate_waypoint/2)
    |> IO.inspect()
    |> calc_distance()
  end

  defp navigate_waypoint(instruction, {w_e, w_n, e, n}) do
    IO.inspect({w_e, w_n, e, n})
    {action, value} = instruction |> String.split_at(1)
    value = value |> String.to_integer()
    IO.inspect({action, value})

    case action do
      "N" ->
        {w_e, w_n, e, n + value}

      "S" ->
        {w_e, w_n, e, n - value}

      "E" ->
        {w_e, w_n, e + value, n}

      "W" ->
        {w_e, w_n, e - value, n}

      "L" ->
        turn(w_e, w_n, e, n, value, fn _, {x, y} ->
          {-y, x}
        end)

      "R" ->
        turn(w_e, w_n, e, n, value, fn _, {x, y} ->
          {y, -x}
        end)

      "F" ->
        {w_e + e * value, w_n + n * value, e, n}
    end
  end

  defp turn(w_e, w_n, e, n, value, rotate) do
    times = div(value, 90)
    {e, n} = Enum.reduce(1..times, {e, n}, rotate)
    {w_e, w_n, e, n}
  end
end
