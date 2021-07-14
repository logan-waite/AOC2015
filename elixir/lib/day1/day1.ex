defmodule Day1 do
  @moduledoc """
  ## Day 1: Not Quite Lisp

  Santa is trying to deliver presents in a large apartment building, but he can't find the right floor - the directions he got are a little confusing. He starts on the ground floor (floor 0) and then follows the instructions one character at a time.

  The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors.  
  """

  @doc """
  An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.

  ## Examples

      iex> Day1.part1("(())")
      0

      iex> Day1.part1("(((")
      3

      iex> Day1.part1("())")
      -1

      iex> Day1.part1(")))")
      -3
  """
  def part1(parens) do
    String.split(parens, "", trim: true)
    |> List.foldl(0, &move_floor/2)
  end

  defp move_floor(direction, current_floor) when direction == "(" do
    current_floor + 1
  end

  defp move_floor(direction, current_floor) when direction == ")" do
    current_floor - 1
  end

  @doc """
  Find the position of the first character that causes Santa to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.
  ## Examples

      iex> Day1.part2(")")
      1

      iex> Day1.part2("()())")
      5
  """
  def part2(input) do
    input
    |> String.split("", trim: true)
    |> move_to_basement(0, 0)
  end

  defp move_to_basement(_directions, current_floor, times) when current_floor == -1 do
    times
  end

  defp move_to_basement(directions, current_floor, times) do
    new_floor = move_floor(Enum.at(directions, times), current_floor)
    move_to_basement(directions, new_floor, times + 1)
  end
end
