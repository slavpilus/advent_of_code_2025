defmodule AOC do
  def input(day) do
    day = String.pad_leading(day, 2, "0")

    priv =
      :code.priv_dir(:advent_of_code_2025)
      |> List.to_string()

    File.read!(Path.join(priv, "inputs/day#{day}.txt"))
  end
end
