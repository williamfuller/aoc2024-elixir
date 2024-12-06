defmodule Day02 do
  def part_1 do 
    input()
    |> Enum.count(&is_safe(&1))
  end

  def part_2 do 
    input()
    |> Enum.filter(fn line -> !is_safe(line) end)
    |> Enum.count(fn line ->  
      0..length(line)
      |> Enum.map(&List.delete_at(line, &1))
      |> Enum.any?(fn reduced_line -> is_safe(reduced_line) end)
    end)  
    |> Kernel.+(part_1())
  end

  # IO
  defp input() do 
    AdventOfCode.getInput("https://adventofcode.com/2024/day/2/input", "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")
    |> parse
  end

  defp parse(input) do 
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> 
      String.split(line) 
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  # logic
  defp is_safe([a, b | _] = list) when a < b do is_safe(:asc, list) end
  defp is_safe([a, b | _] = list) when b < a do is_safe(:desc, list) end
  defp is_safe([a, a | _]) do false end

  defp is_safe(:asc, [a, b | rest]) when b - a in 1..3 do is_safe(:asc, [b | rest]) end
  defp is_safe(:desc, [a, b | rest]) when a - b in 1..3 do is_safe(:desc, [b | rest]) end

  defp is_safe(_, [_ | []]) do true end
  defp is_safe(_, _) do false end
end
