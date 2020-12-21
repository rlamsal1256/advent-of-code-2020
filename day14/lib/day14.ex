defmodule Day14 do
  use Bitwise

  def p1(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> parse()
    |> IO.inspect(label: "parse")
    |> run()
    |> IO.inspect(label: "run")
    |> Map.values()
    |> Enum.sum()
  end

  def run(instructions, mask \\ nil, map \\ %{})
  def run([], _mask, map), do: map

  def run([h | t], mask, map) do
    case h do
      {:mask, new_mask} ->
        run(t, {create_and_mask(new_mask), create_or_mask(new_mask)}, map)

      {:write, addr, value} ->
        masked = apply_mask(mask, value)
        run(t, mask, Map.put(map, addr, masked))
    end
  end

  def p2(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> parse()
    |> IO.inspect(label: "parse")
    |> run_v2()
    |> IO.inspect(label: "run_v2")
    |> Map.values()
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> Enum.map(fn line ->
      case line do
        "mask" <> _ ->
          [_, "mask", mask] = Regex.run(~r/^(mask) = (\w+)$/, line)
          {:mask, mask}

        _ ->
          [_, "mem", addr, value] = Regex.run(~r/^(mem)\[(\d+)\] = (\d+)$/, line)
          {:write, String.to_integer(addr), String.to_integer(value)}
      end
    end)
  end

  def run_v2(instructions, mask \\ nil, map \\ %{})
  def run_v2([], _mask, map), do: map

  def run_v2([h | t], mask, map) do
    case h do
      {:mask, new_mask} ->
        run_v2(t, create_v2_mask(String.graphemes(new_mask)), map)

      {:write, addr, value} ->
        new_map =
          Enum.reduce(apply_v2_mask(mask, addr), map, fn addr, acc ->
            Map.put(acc, addr, value)
          end)

        run_v2(t, mask, new_map)
    end
  end

  defp create_v2_mask(bits, new_bits \\ "")
  defp create_v2_mask([], new_bits), do: [{create_and_mask(new_bits), create_or_mask(new_bits)}]

  defp create_v2_mask([h | t], new_bits) do
    case h do
      "1" ->
        create_v2_mask(t, new_bits <> "1")

      "0" ->
        create_v2_mask(t, new_bits <> "X")

      "X" ->
        create_v2_mask(t, new_bits <> "1") ++ create_v2_mask(t, new_bits <> "0")
    end
  end

  defp create_and_mask(str) do
    str
    |> String.replace("X", "1")
    |> String.to_integer(2)
  end

  defp create_or_mask(str) do
    str
    |> String.replace("X", "0")
    |> String.to_integer(2)
  end

  def apply_v2_mask(mask, num) do
    mask
    |> Enum.map(&apply_mask(&1, num))
  end

  def apply_mask({and_mask, or_mask}, num) do
    (num &&& and_mask) ||| or_mask
  end
end
