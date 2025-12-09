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
    boxes =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index(1)
      |> Enum.map(fn {row, idx} ->
        [x, y, z] = String.split(row, ",") |> Enum.map(&String.to_integer/1)
        {x, y, z, idx}
      end)

    distances =
      for a <- boxes, b <- boxes, a < b do
        {coords(a), coords(b), get_disstance(a, b) |> elem(0)}
      end
      |> Enum.sort_by(&elem(&1, 2))

    connect_all(boxes, MapSet.new(), distances, nil)

    {{a, _, _}, {b, _, _}} = connect_all(boxes, MapSet.new(), distances, nil)

    a * b
  end

  defp connect_all(boxes, connected, distances, last_pair) do
    circuit_ids = boxes |> Enum.map(&elem(&1, 3)) |> Enum.uniq()

    if length(circuit_ids) == 1 do
      last_pair
    else
      {updated_boxes, connected, new_last_pair} =
        get_next_pair_with_last(boxes, connected, distances)

      last_pair = new_last_pair || last_pair
      connect_all(updated_boxes, connected, distances, last_pair)
    end
  end

  defp get_next_pair_with_last(boxes, connected, distances) do
    case Enum.find(distances, fn {c1, c2, _dist} ->
           not MapSet.member?(connected, {c1, c2})
         end) do
      nil ->
        {boxes, connected, nil}

      {c1, c2, _dist} ->
        connected = MapSet.put(connected, {c1, c2})

        id1 = get_circuit_id(boxes, c1)
        id2 = get_circuit_id(boxes, c2)

        {updated_boxes, merged_pair} =
          if id1 != id2 do
            {smaller, larger} = if id1 < id2, do: {id1, id2}, else: {id2, id1}

            updated =
              Enum.map(boxes, fn {x, y, z, id} ->
                if id == smaller, do: {x, y, z, larger}, else: {x, y, z, id}
              end)

            {updated, {c1, c2}}
          else
            {boxes, nil}
          end

        {updated_boxes, connected, merged_pair}
    end
  end

  defp get_circuit_id(boxes, {x, y, z}) do
    {_, _, _, id} = Enum.find(boxes, fn {bx, by, bz, _} -> {bx, by, bz} == {x, y, z} end)
    id
  end
end
