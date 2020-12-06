defmodule Day4 do
  def part_one(contents) do
    contents
    |> Enum.map(fn x -> String.split(x, [" ", "\n"]) end)
    |> Enum.count(&contains_reqd_fields/1)
  end

  defp contains_reqd_fields(key_value_list) do
    req_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    fields =
      key_value_list
      |> Enum.map(&get_key/1)

    req_fields
    |> Enum.all?(fn x -> Enum.member?(fields, x) end)
  end

  defp get_key(key_value) do
    key_value
    |> String.split(":")
    |> List.first()
  end

  defp get_value(key_value) do
    key_value
    |> String.split(":")
    |> List.last()
  end

  def part_two(contents) do
    contents
    |> Enum.map(fn x -> String.split(x, [" ", "\n"]) end)
    |> Enum.filter(&contains_reqd_fields/1)
    |> Enum.count(fn x -> x |> Enum.all?(&is_valid/1) end)
  end

  defp is_valid(key_value) do
    key = get_key(key_value)
    value = get_value(key_value)

    case key do
      "byr" -> Regex.match?(~r/^(19[2-9][0-9]|200[12])$/, value)
      "iyr" -> Regex.match?(~r/^(201[0-9]|2020)$/, value)
      "eyr" -> Regex.match?(~r/^(202[0-9]|2030)$/, value)
      "hgt" -> Regex.match?(~r/((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)$/, value)
      "hcl" -> Regex.match?(~r/^#[0-9a-f]{6}$/, value)
      "ecl" -> Regex.match?(~r/(amb|blu|brn|gry|grn|hzl|oth)/, value)
      "pid" -> Regex.match?(~r/[0-9]{9}/, value)
      _ -> true
    end
  end
end
