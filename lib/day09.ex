defmodule AOC.Day09 do
  def part1(input) do
    coords =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        [x, y] = String.split(row, ",") |> Enum.map(&String.to_integer/1)
        {x, y}
      end)

    for i <- coords, j <- coords, i < j do
      {x1, y1} = i
      {x2, y2} = j
      (x2 - x1 + 1) * (y2 - y1 + 1)
    end
    |> Enum.max()
  end

  def part2(input) do
    IO.inspect(input, label: "input")
  end
end
