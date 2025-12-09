defmodule AOC.Day08 do
  def part1(input) do
    part1(input, 1000)
  end

  def part1(input, iters) do
    boxes =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index(1)
      |> Enum.map(fn {row, idx} ->
        [x, y, z] = String.split(row, ",") |> Enum.map(&String.to_integer/1)
        {x, y, z, idx}
      end)

    {final_boxes, _connected} =
      Enum.reduce(1..iters, {boxes, MapSet.new()}, fn _, {acc_boxes, connected} ->
        {updated_boxes, connected} = get_next_pair(acc_boxes, connected)
        {updated_boxes, connected}
      end)

    final_boxes
    |> Enum.group_by(&elem(&1, 3))
    |> Enum.flat_map(fn
      {0, members} -> List.duplicate(1, length(members))
      {_id, members} -> [length(members)]
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def get_next_pair(boxes, connected) do
    candidates =
      for a <- boxes, b <- boxes, a < b do
        get_disstance(a, b)
      end
      |> Enum.filter(fn {_, a, b} ->
        pair = {coords(a), coords(b)}
        not MapSet.member?(connected, pair)
      end)

    case candidates do
      [] ->
        {boxes, connected}

      _ ->
        {_distance, a, b} = Enum.min_by(candidates, &elem(&1, 0))

        pair = {coords(a), coords(b)}
        connected = MapSet.put(connected, pair)

        id1 = elem(a, 3)
        id2 = elem(b, 3)

        updated_boxes =
          cond do
            id1 != id2 ->
              {smaller, larger} = if id1 < id2, do: {id1, id2}, else: {id2, id1}

              Enum.map(boxes, fn {x, y, z, id} ->
                if id == smaller, do: {x, y, z, larger}, else: {x, y, z, id}
              end)

            true ->
              boxes
          end

        {updated_boxes, connected}
    end
  end

  defp coords({x, y, z, _}), do: {x, y, z}

  def get_disstance({x1, y1, z1, c1}, {x2, y2, z2, c2}) do
    {:math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2) + :math.pow(z1 - z2, 2)),
     {x1, y1, z1, c1}, {x2, y2, z2, c2}}
  end

  def part2(input) do
    IO.inspect(input)
  end
end
