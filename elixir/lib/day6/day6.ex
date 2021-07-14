defmodule Day6 do
  @moduledoc """
  ## Day 6: Probably a Fire Hazard

  Because your neighbors keep defeating you in the holiday house decorating contest year after year, you've decided to deploy one million lights in a 1000x1000 grid.

  Furthermore, because you've been especially nice this year, Santa has mailed you instructions on how to display the ideal lighting configuration.

  Lights in your grid are numbered from 0 to 999 in each direction; the lights at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions include whether to turn on, turn off, or toggle various inclusive ranges given as coordinate pairs. Each coordinate pair represents opposite corners of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers to 9 lights in a 3x3 square. The lights all start turned off.
  """

  @doc """
  """
  def part1(input) do
    input
    |> create_command_list()

  end

  defp create_command_list(input) do
    command_list
    |> Enum.split("\n", trim: true)
    |> (&(Regex.run(~r/(toggle|turn off|turn on) (\d+,\d+) through (\d+,\d+)/, &1))).()
  end

  defp do_command(["toggle", start_coord, end_coord]) do

  end

  defp do_command(["turn off", start_coord, end_coord]) do

  end

  defp do_command(["turn on", start_coord, end_coord]) do

  end



  @doc """
  """
  def part2(input) do

  end
end
