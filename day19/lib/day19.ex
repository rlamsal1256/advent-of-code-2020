defmodule Day19 do
  def p1(filename) do
    {rules, messages} = parse(filename)

    messages |> Enum.count(&match(String.graphemes(&1), rules[0], rules))
  end

  def p2(filename) do
    {rules, messages} = parse(filename)
    rules = rules |> Map.put(8, {[42], [42, 8]}) |> Map.put(11, {[42, 31], [42, 11, 31]})

    messages |> Enum.count(&match(String.graphemes(&1), rules[0], rules))
  end

  def match([], [], _), do: true

  def match([s1 | r], [s2 | tl], rules) when s1 == s2, do: match(r, tl, rules)

  def match(graphemes, [hd | tl], rules) when is_integer(hd),
    do: match(graphemes, next(rules, hd, tl), rules)

  def match(graphemes, [{l, r} | tl], rules),
    do: match(graphemes, l ++ tl, rules) || match(graphemes, r ++ tl, rules)

  def match(_, _, _), do: false

  def next(rules, id, tl) do
    next =
      case rules[id] do
        str when is_binary(str) -> [str]
        {l, r} -> [{l, r}]
        rest -> rest
      end

    next ++ tl
  end

  def parse(filename) do
    [rules, input] = File.read!(filename) |> String.split("\n\n")
    {parse_rules(rules), String.split(input, "\n")}
  end

  def parse_rules(rules) do
    rules
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(fn [k, v] ->
      {String.to_integer(k), v |> String.trim() |> String.split(" ") |> parse_rule()}
    end)
    |> Enum.into(%{})
  end

  def parse_rule(["\"a\""]), do: "a"
  def parse_rule(["\"b\""]), do: "b"

  def parse_rule(list) do
    i = list |> Enum.find_index(&(&1 == "|"))

    case i do
      nil ->
        list |> Enum.map(&String.to_integer/1)

      _ ->
        list
        |> Enum.reject(&(&1 == "|"))
        |> Enum.map(&String.to_integer/1)
        |> Enum.split(i)
    end
  end
end
