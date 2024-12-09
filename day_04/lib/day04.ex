defmodule Day04 do
  @directions [{-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}]
  @diagonals [{-1, -1}, {-1, 1}, {1, 1}, {1, -1}]

  def part1 do
    grid = input()

    Enum.reduce(grid, 0, fn {position, _}, acc ->
      acc + recursive_find(grid, position, ~c"XMAS", @directions)
    end)
  end

  def part2 do
    grid = input()

     Enum.filter(grid, fn {_, letter} -> letter == ?A end)
    |> Enum.count(fn {position, _} -> check_around(grid, position) end)
  end


  # IO
  defp input() do
    AOC.get_input(
      4,
      "session=53616c7465645f5ff44d2dc513e2d20748caf8d1fb506ed7f0f9fa745c45639b445549dba9db95841f5faa7576ed3c84c5bd7c3ca1dcf6b5eacb693b0807012e"
    )
    |> parse
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

  defp check_around(grid, {x, y}) do 
    [tl, tr, br, bl] =
    @diagonals
    |> Enum.map(fn {diff_x, diff_y} -> {x + diff_x, y + diff_y} end)
    |> Enum.map(fn coord -> Map.get(grid, coord) end)

    ([tl, br] == [?M, ?S] || [tl, br] == [?S, ?M]) &&
    ([tr, bl] == [?M, ?S] || [tr, bl] == [?S, ?M])
  end


  defp recursive_find(grid, {x, y}, [l | rest], search_directions) do
    case match?(grid, {x, y}, l) do
      true ->
        Enum.count(search_directions, fn {x_diff, y_diff} ->
          recursive_find(grid, {x + x_diff, y + y_diff}, rest, {}, {x_diff, y_diff})
        end)

      _ ->
        0
    end
  end

  defp recursive_find(grid, {x, y}, [l | rest], _, {x_diff, y_diff}) do
    case match?(grid, {x, y}, l) do
      true -> recursive_find(grid, {x + x_diff, y + y_diff}, rest, {}, {x_diff, y_diff})
      _ -> false
    end
  end

  defp recursive_find(_, _, [], _, _) do
    true
  end

  defp match?(grid, position, char) do
    case Map.get(grid, position) do
      ^char -> true
      _ -> false
    end
  end
end
