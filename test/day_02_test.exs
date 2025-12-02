defmodule AOC.Day02Test do
  use ExUnit.Case

  test "day01part1" do
    assert AOC.Day02.part1(
             "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
           ) == 1_227_775_554
  end

  test "day01part2" do
    IO.puts("pass")
  end
end
