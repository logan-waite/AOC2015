defmodule Day4 do
  @moduledoc """
  ## Day 4: The Ideal Stocking Stuffer

  Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts for all the economically forward-thinking little girls and boys.

  To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal.
  """

  @doc """
  To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

  ## Examples

  iex> Day4.part1("abcdef")
  609043

  iex> Day4.part1("pqrstuv")
  1048970
  """
  def part1(input) do
    input
    |> String.trim()
    |> find_hash("00000", 1)
  end

  defp find_hash(key, starts_with, num) do
    hash = key <> to_string(num)
    |> (&(:crypto.hash(:md5, &1))).()
    |> Base.encode16()

    if String.starts_with?(hash, starts_with) do
      num
    else
      find_hash(key, starts_with, num + 1)
    end
  end

  @doc """
  Find an AdventCoin hash that starts with 6 zeroes
  """
  def part2(input) do
    input
    |> String.trim()
    |> find_hash("000000", 1)
  end
end
