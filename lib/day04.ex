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

    process_until_done(grid, 0)
  end

  defp process_until_done(grid, total) do
    {new_grid, count} = process_grid(grid)

    if count == 0 do
      total
    else
      process_until_done(new_grid, total + count)
    end
  end

  defp process_grid(grid) do
    {new_grid, counter} =
      Enum.reduce(grid, {Map.new(), 0}, fn {{x, y}, cell}, {acc_grid, acc_count} ->
        if cell != "@" do
          {Map.put(acc_grid, {x, y}, "."), acc_count}
        else
          neighbor_count =
            neighbors({x, y})
            |> Enum.count(fn coord -> Map.get(grid, coord) == "@" end)

          if neighbor_count < 4 do
            {Map.put(acc_grid, {x, y}, "."), acc_count + 1}
          else
            {Map.put(acc_grid, {x, y}, "@"), acc_count}
          end
        end
      end)

    {new_grid, counter}
  end
end
