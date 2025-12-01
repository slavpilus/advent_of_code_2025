defmodule AOC.Day01 do
  def part1(input) do
    {_, counter} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> extract(line) end)
      |> Enum.reduce({50, 0}, fn {rotation, {moves}}, {position, counter} ->
        case rotation do
          "R" ->
            if position + moves > 99 do
              reminder = rem(position + moves, 100)

              if reminder == 0 do
                {reminder, counter + 1}
              else
                {reminder, counter}
              end
            else
              {position + moves, counter}
            end

          "L" ->
            if position - moves < 1 do
              reminder = abs(rem(position - moves, 100))

              if reminder == 0 do
                {reminder, counter + 1}
              else
                {100 - reminder, counter}
              end
            else
              {position - moves, counter}
            end
        end
      end)

    counter
  end

  defp extract(line) do
    case Regex.run(~r/(L|R)(\d+)/, line) do
      [_, dir, step] ->
        {dir, {String.to_integer(step)}}
    end
  end

  def part2(_input) do
    IO.puts("part 2")
    "part 2"
  end
end
