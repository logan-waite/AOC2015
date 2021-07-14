defmodule Day3 do
  require Integer
  @moduledoc """
  ## Day 3: Perfectly Spherical Houses in a Vacuum

  Santa is delivering presents to an infinite two-dimensional grid of houses.

  He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.
  """

  @doc """
  However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?
  
  ## Examples

  iex> Day3.part1(">")
  2

  iex> Day3.part1("^>v<")
  4

  iex> Day3.part1("^v^v^v^v^v")
  2
  """
  def part1(input) do
    input
    |> String.split("", trim: true)
    |> List.foldl([{0,0}], &(move(&1, &2)))
    |> Enum.uniq()
    |> length()
  end

  defp move(next, previous) do
    {x, y} = hd(previous)
    case next do
      "^" -> {x, y + 1}
      "v" -> {x, y - 1}
      ">" -> {x + 1, y}
      "<" -> {x - 1, y}
    end
    |> (&([&1 | previous])).()
  end

  @doc """
  Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

  This year, how many houses receive at least one present?

  ## Examples

  iex> Day3.part2("^v")
  3

  iex> Day3.part2("^>v<")
  3

  iex> Day3.part2("^v^v^v^v^v")
  11
  """
  def part2(input) do
    input
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> List.foldl([santa: [{0,0}], robo: [{0,0}]], &(move_robo_or_santa(&1, &2)))
    |> Enum.flat_map(fn {_k,v} -> v end)
    |> Enum.uniq()
    |> length()
  end

  defp move_robo_or_santa({dir, i}, previous) do
    if Integer.is_even(i) do
      {_cur, new} = Keyword.get_and_update(previous, :santa, fn cur -> {cur, move(dir, cur)} end)
      new
    else
      {_cur, new} = Keyword.get_and_update(previous, :robo, fn cur -> {cur, move(dir, cur)} end)
      new
    end
  end
end
