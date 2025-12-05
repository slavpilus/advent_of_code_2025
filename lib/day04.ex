defmodule AOC.Day04 do
  def part1(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, r} ->
        row
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.map(fn {char, c} -> {{r, c}, char} end)
      end)
      |> Map.new()

    grid
    |> Enum.filter(fn {_coord, cell} -> cell == "@" end)
    |> Enum.map(fn {{x, y}, _} ->
      all_neighbors = neighbors({x, y})

      sum_of_present =
        all_neighbors
        |> Enum.map(fn coord ->
          if Map.get(grid, coord) == "@" do
            1
          else
            0
          end
        end)
        |> Enum.sum()

      if sum_of_present < 4 do
        1
      else
        0
      end
    end)
    |> Enum.sum()
  end

  def neighbors({r, c}) do
    for nr <- -1..1, nc <- -1..1, {nr, nc} != {0, 0} do
      {r + nr, c + nc}
    end
  end

  def part2(input) do
    IO.puts(input)
  end
end
