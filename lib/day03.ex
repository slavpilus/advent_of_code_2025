defmodule AOC.Day03 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn bank -> get_joltage(bank) end)
    |> Enum.sum()
  end

  defp get_joltage(bank) do
    bank
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.map(fn {x, i} ->
      bank
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.map(fn {y, j} ->
        if i < j do
          String.to_integer(x <> y)
        else
          0
        end
      end)
      |> Enum.max()
    end)
    |> Enum.max()
  end

  def part2(input) do
    IO.inspect(input)
  end
end
