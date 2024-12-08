defmodule Day04 do
  def part1 do
    input()
  end

  # IO
  defp input() do
    AOC.get_input(
      4,
      "session=53616c7465645f5ff44d2dc513e2d20748caf8d1fb506ed7f0f9fa745c45639b445549dba9db95841f5faa7576ed3c84c5bd7c3ca1dcf6b5eacb693b0807012e"
    )
    |> parse
    |> find(~c"XMAS")
  end

  defp parse(input) do
    String.trim(input)
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      String.to_charlist(line)
      |> Enum.with_index()
      |> Enum.map(fn {letter, col} ->
        {{row, col}, letter}
      end)
    end)
    |> Map.new()
  end

  # logic
  defp directions() do
    [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
  end

  defp find(grid, word) do
    Enum.reduce(grid, 0, fn {position, _}, acc ->
      case recursive_find(grid, position, word) do
        true -> acc + 1
        false -> acc
      end
    end)
  end

  defp recursive_find(grid, position, [_ | []]) do
    case Map.get(grid, position) do
      nil -> false
      _ -> true
    end
  end

  defp recursive_find(grid, {x, y}, [l | rest]) do
    case match?(grid, {x, y}, l) do
      true ->
        Enum.any?(directions(), fn {x_diff, y_diff} ->
          position = {x + x_diff, y + y_diff}
          recursive_find(grid, position, rest)
        end)

      _ ->
        false
    end
  end

  defp match?(grid, position, char) do
    case Map.get(grid, position) do
      ^char -> true
      _ -> false
    end
  end
end
