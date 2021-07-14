defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "part 1 example 1" do
    assert Day1.part1("(())") == 0
    assert Day1.part1("()()") == 0
  end

  test "part 1 example 2" do
    assert Day1.part1("(((") == 3
    assert Day1.part1("(()(()(") == 3
  end

  test "part 1 example 3" do
    assert Day1.part1("))(((((") == 3
  end

  test "part 1 example 4" do
    assert Day1.part1("())") == -1
    assert Day1.part1("))(") == -1
  end

  test "part 1 example 5" do
    assert Day1.part1(")))") == -3
    assert Day1.part1(")())())") == -3
  end
end
