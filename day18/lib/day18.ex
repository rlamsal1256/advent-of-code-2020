defmodule Day18 do
  def p1(filename) do
    parse(filename)
    |> Enum.map(fn line -> eval(line, &eval_left_to_right/1) end)
    |> Enum.sum()
  end

  defp parse(filename) do
    File.read!(filename) |> String.split("\n", trim: true)
  end

  defp eval(line, eval_fn) do
    if String.contains?(line, "(") do
      line
      |> String.replace(" ", "")
      |> String.split("", trim: true)
      |> eval_parens_first(eval_fn, &eval/2)
    else
      eval_fn.(line)
    end
  end

  def eval_parens_first(list, eval_fn, eval_rest) do
    {i, j} =
      list
      |> Enum.with_index()
      |> find_open_close_parens(false, nil)

    value_within_parens = list |> Enum.slice(i..j) |> Enum.join() |> eval_fn.()

    new_list =
      if i == 0 do
        [value_within_parens] ++ Enum.slice(list, (j + 1)..(length(list) - 1))
      else
        Enum.slice(list, 0..(i - 1)) ++
          [value_within_parens] ++ Enum.slice(list, (j + 1)..(length(list) - 1))
      end

    eval_rest.(new_list |> Enum.join(), eval_fn)
  end

  defp find_open_close_parens(_, open_idx, close_idx)
       when is_integer(open_idx) and is_integer(close_idx),
       do: {open_idx, close_idx}

  defp find_open_close_parens([{v, i} | t], open_idx, close_idx) do
    case v do
      "(" -> find_open_close_parens(t, i, close_idx)
      ")" -> find_open_close_parens(t, open_idx, i)
      _ -> find_open_close_parens(t, open_idx, close_idx)
    end
  end

  defp eval_left_to_right(line) do
    line
    |> String.replace(" ", "")
    |> String.split(~r{[\+|\*]}, include_captures: true)
    |> add_parens_from_left_to_right
    |> do_math
  end

  defp add_parens_from_left_to_right(list) do
    operator_count = list |> Enum.count(&is_operator/1)
    opening_parens = Enum.reduce(1..operator_count, "", fn _, acc -> acc <> "(" end)
    [opening_parens | add_closing_parens(list, 1, 0)]
  end

  defp is_operator("+"), do: true
  defp is_operator("*"), do: true
  defp is_operator(_), do: false

  defp add_closing_parens(list, index, count) when index + count >= length(list), do: list

  defp add_closing_parens(list, index, count) do
    add_closing_parens(List.insert_at(list, index + count, ")"), index + 2, count + 1)
  end

  def p2(filename) do
    parse(filename)
    |> Enum.map(fn line -> eval(line, &eval_with_different_precedence/1) end)
    |> Enum.sum()
  end

  defp eval_with_different_precedence(line) do
    line
    |> String.replace([" ", "(", ")"], "")
    |> String.split(~r{[\+|\*]}, include_captures: true)
    |> eval_addition_first
    |> do_math
  end

  defp eval_addition_first(list) do
    i = Enum.find_index(list, &(&1 == "+"))

    case i do
      nil ->
        list

      1 ->
        eval =
          list
          |> Enum.slice((i - 1)..(i + 1))
          |> do_math

        new_list = [eval] ++ Enum.slice(list, (i + 2)..(length(list) - 1))
        eval_addition_first(new_list)

      _ ->
        eval =
          list
          |> Enum.slice((i - 1)..(i + 1))
          |> do_math

        new_list =
          Enum.slice(list, 0..(i - 2)) ++ [eval] ++ Enum.slice(list, (i + 2)..(length(list) - 1))

        eval_addition_first(new_list)
    end
  end

  defp do_math(list) do
    list
    |> Enum.join()
    |> Code.eval_string()
    |> elem(0)
  end
end
