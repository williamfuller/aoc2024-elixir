defmodule Day04 do
  def part1 do 
    input()
  end

  # IO
  defp input() do 
    AOC.get_input(4, "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")
    |> parse
    |> find(~c"XMAS")
  end

  defp parse(input) do 
    String.split(input, "\n")
    |> Enum.with_index
    |> Enum.flat_map(fn {line, row} ->
      String.to_charlist(line)
      |> Enum.with_index
      |> Enum.map(fn {letter, col} ->
        {{row, col}, letter} 
      end)
    end)
    |> Map.new
  end

  # logic
  defp directions() do 
    [{-1, -1}, {-1, 0}, {-1, 1},
    {0, -1}, {0, 1},
    {1, -1}, {1, 0}, {1, 1}]
  end

  defp find(grid, _word) do 
    Enum.reduce(grid, 0, fn {position, _}, acc -> 
      case match?(grid, position, ?X) do 
        true -> acc+1
        false -> acc
      end
    end)
  end

  defp match?(grid, position, letter) do 
     case Map.get(grid, position) do 
        ^letter -> true
        _ -> false
     end
  end
end
