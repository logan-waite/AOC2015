defmodule AOC do
  @moduledoc """
  Advent Of Code 2015

  This module provides tools for testing and running the challenges
  """

  @doc """
  Reads the input file for the given `day_number` and runs it through the provided function (ex. Day1.part1);
  
  Solution functions should be unary (receiving only the input for the challenge)
  """
  def attempt_solution(solution_fn) do
      get_input(solution_fn)
      |> File.read!()
      |> solution_fn.()
  end

  defp get_input(solution_fn) do
  
    solution_fn
    |> Function.info()
    |> Keyword.get(:module)
    |> to_string()
    |> (fn name -> Regex.run(~r/Day(\d+)/, name) end).()
    |> Enum.at(1)
    |> (&("./lib/day#{&1}/input.txt")).()
  end

  @doc """
  Creates the files for a new Advent of Code day. This includes:
  - a directory containing 
    - a module for the given day
    - an `input.txt` file to save your puzzle input
  - a new `*_test.exs` file for that day

  """
  def setup_new_day(day) do
    dir = "lib/day#{day}"
    create_day_dir(dir)
    File.write!(dir <> "/input.txt", "")
    create_from_template("day", day, dir <> "/day#{day}.ex")
    create_from_template("day_test", day, "test/day#{day}_test.exs")
  end

  defp create_day_dir(dir) do
    if not File.exists?(dir) do
      File.mkdir!(dir)
    end
  end

  defp create_from_template(name, day, target_path) do
    File.read!("templates/#{name}.template")
    |> String.replace("{-number-}", Integer.to_string(day))
    |> (&(File.write!(target_path, &1))).()
  end
end
