defmodule Day03 do
  def part_1() do 
    input = input()
    mul(input)
  end

  def part_2() do 
    input() <> "do()"
    |> String.replace(~r/(don't\(\)[\S\s]*?do\(\))/,"")
    |> mul
  end

  defp mul(data) do 
    Regex.scan(~r/mul\((\d+),(\d+)\)/, data)
    |> Enum.reduce(0, fn [_ | [a, b]], acc ->
      acc + (String.to_integer(a) * String.to_integer(b))
    end)
  end

  # IO
  defp input() do 
    AdventOfCode.getInput("https://adventofcode.com/2024/day/3/input", "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")
    |> parse
  end

  defp parse(input) do 
    input
  end
end
