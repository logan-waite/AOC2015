defmodule Day5 do
  @moduledoc """
  ## Day 5: Doesn't He Have Intern-Elves For This?

  Santa needs help figuring out which strings in his text file are naughty or nice.

  A nice string is one with all of the following properties:

  - It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
  - It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
  - It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
  """

  @doc """
  How many strings are nice?

  iex> Day5.part1("ugknbfddgicrmopn
  iex>aaa")
  2

  iex> Day5.part1("dvszwmarrgswjxmb
  iex>haegwjzuvuyypxyu
  iex>jchzalrnumimnmhp")
  0

  iex> Day5.part1("dvszwmarrgswjxmb
  iex>ugknbfddgicrmopn
  iex>haegwjzuvuyypxyu
  iex>aaa
  iex>jchzalrnumimnmhp")
  2


  """
  def part1(input) do
    input
    |> prep_input()
    |> Enum.map(&(Regex.match?(~r/^(?=(?:\w*(\w)\1))(?=(?:\w*[aeiou]){3,})(?!\w*(ab|cd|pq|xy)).*$/, &1)))
    |> Enum.frequencies()
    |> Map.get(true)
  end

  defp prep_input(input) do
    input
    |> String.split("\n", trim: true)
  end

  # Not 192 (too high)
  # Not 14
  @doc """
  """
  def part2(input) do
    input
    |> prep_input()
    |> Enum.map(&(Regex.match?(~r/^(?=\w*(\w)\w\1)(?=\w*(\w\w).*\2){2,}.*$/, &1)))
    |> Enum.frequencies()
    |> Map.get(true)
  end
end
