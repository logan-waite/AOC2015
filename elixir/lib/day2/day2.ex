defmodule Day2 do
    @moduledoc """
    ## Day 2: I Was Told There Would Be No Math

    The elves are running low on wrapping paper and ribbon, and so they need to submit an order for more. 
    
    They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

    Fortunately, every present is a box (a perfect right rectangular prism). 
    """

    @doc """
    Find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. 
    
    The elves also need a little extra paper for each present: the area of the smallest side.

    ## Examples

        iex> Day2.part1("2x3x4")
        58

        iex> Day2.part1("1x1x10")
        43

        iex> Day2.part1("2x3x4
        iex>1x1x10")
        101

    """
    def part1 (input) do
        tasks = input
        |> prep_sides()
        |> Enum.reduce([], fn cur, acc -> [Task.async(fn -> get_square_footage(cur) end) | acc] end)

        Task.await_many(tasks)
        |> Enum.sum()
    end

    defp prep_sides(input) do
        input
        |> String.split("\n", trim: true)
        |> Enum.map(&(String.split(&1, "x", trim: true)))
    end

    defp get_square_footage(dimensions) do
        {h,l,w} = dimensions 
            |> Enum.map(&(String.to_integer(&1))) 
            |> List.to_tuple()

        side1 = w * h
        side2 = l * w
        side3 = h * l
        extra = Enum.min([side1, side2, side3])

        2 * side1 + 2 * side2 + 2 * side3 + extra
    end

    @doc """
    Ribbon is all the same width, so they only have to worry about the length they need to order.

    The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present.
    
    ## Examples
        iex> Day2.part2("2x3x4")
        34

        iex> Day2.part2("1x1x10")
        14

        iex> Day2.part2("2x3x4
        iex>1x1x10")
        48
    """
    def part2(dimensions) do
        tasks = dimensions
        |> prep_sides()
        |> Enum.reduce([], fn cur, acc -> [Task.async(fn -> get_ribbon_length(cur) end) | acc] end)

        Task.await_many(tasks)
        |> Enum.sum()    
    end

    defp get_ribbon_length(dimensions) do
        smallest_perimeter = get_smallest_perimeter(dimensions)
        cubic_feet = get_cubic_feet(dimensions)

        smallest_perimeter + cubic_feet
    end

    defp get_cubic_feet(dimensions) do
        dimensions
        |> Enum.map(&(String.to_integer(&1)))
        |> Enum.reduce(fn cur, acc -> acc * cur end)
    end

    defp get_smallest_perimeter(dimensions) do
        double = &(&1 * 2)

        dimensions
        |> Enum.map(&(String.to_integer(&1)))
        |> Enum.sort()
        |> Enum.take(2)
        |> Enum.sum()
        |> double.()
    end
end