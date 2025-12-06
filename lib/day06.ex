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

    out =
      for i <- 0..(map_size(n1i) - 1) do
        if Map.get(opi, i) == "*" do
          Map.get(n1i, i) * Map.get(n2i, i) * Map.get(n3i, i) * Map.get(n4i, i)
        else
          Map.get(n1i, i) + Map.get(n2i, i) + Map.get(n3i, i) + Map.get(n4i, i)
        end
      end
      |> Enum.sum()

    IO.inspect(out, label: "out")
    out
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
    IO.inspect(input, label: "input")
  end
end
