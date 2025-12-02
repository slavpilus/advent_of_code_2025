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

  def part2(input) do
    {_, counter} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> extract(line) end)
      |> Enum.reduce({50, 0}, fn {rotation, {moves}}, {position, counter} ->
        case rotation do
          "R" ->
            if position + moves > 99 do
              whole = div(position + moves, 100)
              reminder = rem(position + moves, 100)

              cond do
                whole != 0 and reminder != 0 -> {reminder, counter + whole}
                whole != 0 -> {reminder, counter + whole}
                true -> {100 - reminder, counter}
              end
            else
              {position + moves, counter}
            end

          "L" ->
            if position - moves < 1 do
              reminder = rem(moves, 100)
              whole = div(moves, 100)
              new_pos = Integer.mod(position - moves + 100, 100)

              extra =
                if position != 0 and reminder > 0 and position - reminder <= 0 do
                  1
                else
                  0
                end

              all_crosses = whole + extra
              {new_pos, counter + all_crosses}
            else
              {position - moves, counter}
            end
        end
      end)

    counter
  end
end
