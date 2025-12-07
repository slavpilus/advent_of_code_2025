defmodule AOC.Day06 do
  def part1(input) do
    [n1, n2, n3, n4, op] =
      input
      |> String.split("\n", trim: true)

    n1i = to_integer_list_index(n1)
    n2i = to_integer_list_index(n2)
    n3i = to_integer_list_index(n3)
    n4i = to_integer_list_index(n4)
    opi = to_index(op)

    for i <- 0..(map_size(n1i) - 1) do
      if Map.get(opi, i) == "*" do
        Map.get(n1i, i) * Map.get(n2i, i) * Map.get(n3i, i) * Map.get(n4i, i)
      else
        Map.get(n1i, i) + Map.get(n2i, i) + Map.get(n3i, i) + Map.get(n4i, i)
      end
    end
    |> Enum.sum()
  end

  defp to_index(col) do
    col
    |> String.split(" ", trim: true)
    |> Enum.with_index()
    |> Map.new(fn {val, i} -> {i, val} end)
  end

  defp to_integer_list_index(col) do
    col
    |> String.split(" ", trim: true)
    |> Enum.map(fn s ->
      String.to_integer(s)
    end)
    |> Enum.with_index()
    |> Map.new(fn {val, i} -> {i, val} end)
  end

  def part2(input) do
    pivoted =
      input
      |> String.split("\n", trim: true)
      |> Enum.drop(-1)
      |> Enum.map(&String.codepoints/1)
      |> Enum.zip_with(& &1)
      |> Enum.map(&Enum.join/1)
      |> Enum.chunk_by(fn x -> String.trim(x) == "" end)
      |> Enum.reject(fn chunk -> String.trim(hd(chunk)) == "" end)
      |> Enum.with_index()
      |> Map.new(fn {chunk, i} -> {i, chunk} end)

    ops =
      input
      |> String.split("\n", trim: true)
      |> List.last()
      |> String.split(" ", trim: true)
      |> Enum.with_index()
      |> Map.new(fn {val, i} -> {i, val} end)

    for i <- 0..(map_size(pivoted) - 1) do
      op =
        Map.get(ops, i)

      if op == "*" do
        Map.get(pivoted, i)
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.to_integer/1)
        |> Enum.product()
      else
        Map.get(pivoted, i)
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum()
      end
    end
    |> Enum.sum()
  end
end
