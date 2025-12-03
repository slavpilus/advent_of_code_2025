defmodule AOC.Day02 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line -> String.split(line, ",") end)
    |> Enum.map(fn range -> get_range(range) end)
    |> Enum.map(fn range -> find_incorrect(range) end)
    |> Enum.sum()
  end

  defp find_incorrect({start, stop}) do
    start..stop
    |> Enum.map(fn n -> Integer.to_string(n) end)
    |> Enum.reduce(0, fn v, i ->
      {l, r} = String.split_at(v, div(String.length(v), 2))

      if l == r do
        i + String.to_integer(v)
      else
        i
      end
    end)
  end

  defp get_range(text) do
    case Regex.run(~r/(\d+)-(\d+)/, text) do
      [_, start, stop] ->
        {String.to_integer(start), String.to_integer(stop)}
    end
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line -> String.split(line, ",") end)
    |> Enum.map(fn range -> get_range(range) end)
    |> Enum.map(fn range -> find_incorrect2(range) end)
    |> Enum.sum()
  end

  defp find_incorrect2({start, stop}) do
    start..stop
    |> Enum.filter(fn n -> is_invalid?(Integer.to_string(n)) end)
    |> Enum.sum()
  end

  defp is_invalid?(s) do
    len = String.length(s)

    if len < 2 do
      false
    else
      Enum.any?(1..(len - 1)//1, fn chunk_size ->
        rem(len, chunk_size) == 0 and
          s
          |> String.codepoints()
          |> Enum.chunk_every(chunk_size)
          |> Enum.map(&Enum.join/1)
          |> Enum.uniq()
          |> length() == 1
      end)
    end
  end
end
