defmodule Day2 do
  def part_one(entries) do
    entries
    |> Enum.count(&is_password_valid/1)
  end

  def is_password_valid(line) do
    [min_max, letter, password] = String.split(line, ~r{\s})
    [min, max] = String.split(min_max, ~r{-})
    [letter, _] = String.split(letter, ~r{:})

    count = Enum.count(String.graphemes(password), fn x -> x == letter end)
    count >= String.to_integer(min) && count <= String.to_integer(max)
  end

  def part_two(entries) do
    entries
    |> Enum.count(&is_password_really_valid/1)
  end

  def is_password_really_valid(line) do
    # [positions, letter, password] = String.split(line, ~r{\s})
    # [pos1, pos2] = String.split(positions, ~r{-})
    # [letter, _] = String.split(letter, ~r{:})

    [pos1, pos2, letter, password] = Regex.split(~r{(\d+)-(\d+) ([a-z]): ([a-z]+)}, line, include_captures: true)

    first_pos_match = String.at(password, String.to_integer(pos1) - 1) == letter
    sec_pos_match = String.at(password, String.to_integer(pos2) - 1) == letter

    (first_pos_match  && !sec_pos_match) || (!first_pos_match && sec_pos_match)
  end
end
