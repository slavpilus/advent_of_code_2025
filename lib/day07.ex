defmodule AOC.Day07 do
  def part1(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, y} ->
        row
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.map(fn {char, x} -> {{x, y}, char} end)
      end)
      |> Map.new()

    max_y = grid |> Map.keys() |> Enum.map(fn {_, y} -> y end) |> Enum.max()
    start = get_starting_point(grid)
    {count, _visited} = get_next_splitter(start, grid, max_y, MapSet.new())
    count
  end

  def get_next_splitter({x, y}, grid, max_y, visited) do
    found =
      Enum.find(y..max_y, fn i ->
        Map.get(grid, {x, i}) == "^"
      end)

    case found do
      nil ->
        {0, visited}

      i ->
        coord = {x, i}

        if MapSet.member?(visited, coord) do
          {0, visited}
        else
          visited = MapSet.put(visited, coord)

          {left_count, visited} = get_next_splitter({x - 1, i + 1}, grid, max_y, visited)
          {right_count, visited} = get_next_splitter({x + 1, i + 1}, grid, max_y, visited)

          {1 + left_count + right_count, visited}
        end
    end
  end

  def get_starting_point(map) do
    Enum.find_value(map, fn {coord, val} -> if val == "S", do: coord end)
  end

  def part2(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, y} ->
        row
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.map(fn {char, x} -> {{x, y}, char} end)
      end)
      |> Map.new()

    max_y = grid |> Map.keys() |> Enum.map(fn {_, y} -> y end) |> Enum.max()
    start = get_starting_point(grid)
    {count, _cache} = get_quantum_splitters(start, grid, max_y, %{})
    count
  end

  def get_quantum_splitters({x, y}, grid, max_y, cache) do
    case Map.get(cache, {x, y}) do
      nil ->
        found =
          Enum.find(y..max_y, fn i ->
            Map.get(grid, {x, i}) == "^"
          end)

        {result, cache} =
          case found do
            nil ->
              {1, cache}

            i ->
              {left, cache} = get_quantum_splitters({x - 1, i + 1}, grid, max_y, cache)
              {right, cache} = get_quantum_splitters({x + 1, i + 1}, grid, max_y, cache)
              {left + right, cache}
          end

        {result, Map.put(cache, {x, y}, result)}

      cached ->
        {cached, cache}
    end
  end
end
