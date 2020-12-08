defmodule Day8 do
  def part_one(file_name) do
    {:infinite, acc} =
      parse(file_name)
      |> run([], 0, 0)

    acc
  end

  defp parse(file_name) do
    {:ok, contents} = File.read(file_name)

    contents
    |> String.split("\n", trim: true)
  end

  defp run(instructions, visited, index, acc) do
    cond do
      Enum.member?(visited, index) ->
        {:infinite, acc}

      index == length(instructions) ->
        {:complete, acc}

      true ->
        [operation, argument] = instructions |> Enum.at(index) |> String.split(" ")
        argument = String.to_integer(argument)
        visited = [index | visited]

        case operation do
          "acc" ->
            run(instructions, visited, index + 1, acc + argument)

          "jmp" ->
            run(instructions, visited, index + argument, acc)

          "nop" ->
            run(instructions, visited, index + 1, acc)
        end
    end
  end

  def get_op(instruction) do
    instruction |> String.split(" ") |> List.first()
  end

  defp get_nop_and_jmp_indexes(contents) do
    contents
    |> Enum.with_index()
    |> Enum.filter(fn {instruction, _idx} ->
      get_op(instruction) == "nop" || get_op(instruction) == "jmp"
    end)
    |> Enum.map(fn {_, idx} -> idx end)
  end

  def part_two(file_name) do
    contents = parse(file_name)

    contents
    |> get_nop_and_jmp_indexes()
    |> Enum.find_value(fn idx ->
      new_contents = switch_nop_jmp(contents, idx)

      {state, acc} =
        new_contents
        |> run([], 0, 0)

      if state == :complete, do: acc
    end)
  end

  defp switch_nop_jmp(contents, idx) do
    contents
    |> List.update_at(idx, fn instruction ->
      [operation, argument] = instruction |> String.split()

      case operation do
        "nop" -> "jmp " <> argument
        "jmp" -> "nop " <> argument
      end
    end)
  end
end
