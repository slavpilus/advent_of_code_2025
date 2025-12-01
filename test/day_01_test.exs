defmodule AOC.Day01Test do
  use ExUnit.Case

  test "day01part1" do
    assert AOC.Day01.part1("L5") == 0
    assert AOC.Day01.part1("L50") == 1
    assert AOC.Day01.part1("L150") == 1
    assert AOC.Day01.part1("R50") == 1
    assert AOC.Day01.part1("R5") == 0
    assert AOC.Day01.part1("L68
L30
R48
L5
R60
L55
L1
L99
R14
L82") == 3
  end
end
