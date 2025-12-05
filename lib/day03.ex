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
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn bank -> get_joltage2(bank) end)
    |> Enum.sum()
  end

  defp get_joltage2(bank) do
    digits = bank |> String.codepoints() |> Enum.map(&String.to_integer/1)
    n = length(digits)

    pick_digits(digits, n, 12, 0, [])
    |> Integer.undigits()
  end

  defp pick_digits(_digits, _n, 0, _cursor, acc), do: Enum.reverse(acc)

  defp pick_digits(digits, n, remaining, cursor, acc) do
    max_end = n - remaining
    candidates = Enum.slice(digits, cursor..max_end)
    max_digit = Enum.max(candidates)
    offset = Enum.find_index(candidates, fn d -> d == max_digit end)

    IO.inspect(cursor: cursor, max: max_digit, acc: acc)

    pick_digits(digits, n, remaining - 1, cursor + offset + 1, [max_digit | acc])
  end
end
