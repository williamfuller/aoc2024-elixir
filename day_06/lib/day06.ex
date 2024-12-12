defmodule Day06 do
  def part_1() do
    map = input()

    {guard_index, _} = Enum.find(map, fn {_, element} -> element == "^" end)
    {steps, _, _} = walk(guard_index, {0, -1}, map, MapSet.new())
    steps
  end

  def part_2() do
    map = input()
    {guard_index, _} = Enum.find(map, fn {_, element} -> element == "^" end)
    {_, visited, _} = walk(guard_index, {0, -1}, map, MapSet.new())

    findLoop(guard_index, MapSet.to_list(visited), map)
  end

  defp findLoop(start_pos, options, map, loop_count \\ 0)

  defp findLoop(start_pos, [obstruction_pos | options], map, loop_count) do
    map_with_obstuction = %{map | obstruction_pos => "*"}

    case walk(start_pos, {0, -1}, map_with_obstuction, MapSet.new()) do
      {_, _, true} -> findLoop(start_pos, options, map, loop_count + 1)
      _ -> findLoop(start_pos, options, map, loop_count)
    end
  end

  defp findLoop(_, [], _, loop_count) do
    loop_count
  end

  defp walk(current_pos, direction, map, visited, steps \\ 0)

  defp walk(_, _, map, visited, steps) when steps >= map_size(map) do
    {MapSet.size(visited), visited, true}
  end

  defp walk({x, y}, {x_diff, y_diff}, map, visited, steps) do
    visited = MapSet.put(visited, {x, y})

    case Map.get(map, {x + x_diff, y + y_diff}) do
      nil ->
        {MapSet.size(visited), visited, false}

      "." ->
        walk(
          {x + x_diff, y + y_diff},
          {x_diff, y_diff},
          map,
          visited,
          steps + 1
        )

      "^" ->
        walk(
          {x + x_diff, y + y_diff},
          {x_diff, y_diff},
          map,
          visited,
          steps + 1
        )

      _ ->
        walk({x, y}, rotate_90({x_diff, y_diff}), map, visited, steps)
    end
  end

  defp rotate_90({x, y}) do
    {-y, x}
  end

  # IO
  defp input() do
    AOC.get_input(
      6,
      "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a"
    )
    |> parse
  end

  defp parse(input) do
    String.split(input, "\n", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {line, y} ->
      String.split(line, "", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {element, x} -> {element, x, y} end)
    end)
    |> List.flatten()
    |> Map.new(fn {element, x, y} -> {{x, y}, element} end)
  end
end
