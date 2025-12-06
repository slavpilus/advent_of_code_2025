defmodule AOC.Day05Test do
  use ExUnit.Case

  test "day05part1" do
    assert AOC.Day05.part1("3-5
10-14
16-20
12-18

1
5
8
11
17
32") == 3
  end

  test "day05part2" do
    assert AOC.Day05.part2("3-5
10-14
16-20
12-18

1
5
8
11
17
32") == 14
  end
end
