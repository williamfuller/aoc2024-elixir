defmodule Day04 do
  def part1 do 
    input()
  end

  # IO
  defp input() do 
    AdventOfCode.getInput(4, "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")
    |> parse
  end

  defp parse(input) do 
    String.split(input, "\n")
    |> Enum.with_index
    |> Enum.map(fun {element, _} -> String.split(element, "") |> Enum.with_index end)
  end

  # logic
  defp directions() do 
    [{-1, -1}, {-1, 0}, {-1, 1},
    {0, -1}, {0, 1},
    {1, -1}, {1, 0}, {1, 1}]
  end
end
