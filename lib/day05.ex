defmodule AOC.Day05 do
  def part1(input) do
    ranges =
      input
      |> String.split("\n", trim: true)
      |> Enum.filter(fn row -> String.contains?(row, "-") end)
      |> Enum.map(fn row ->
        {from, to} = extract(row)
        IO.inspect(from, label: "from")
        IO.inspect(to, label: "to")
        from..to
      end)

    input
    |> String.split("\n", trim: true)
    |> Enum.filter(fn row -> not String.contains?(row, "-") end)
    |> Enum.map(fn ingredient -> String.to_integer(ingredient) end)
    |> Enum.filter(fn ingredient -> Enum.any?(ranges, fn range -> ingredient in range end) end)
    |> Enum.count()
  end

  defp extract(line) do
    case Regex.run(~r/(\d+)-(\d+)/, line) do
      [_, from, to] ->
        {String.to_integer(from), String.to_integer(to)}
    end
  end

  def part2(input) do
    IO.puts(input)
  end
end
