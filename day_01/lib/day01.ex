defmodule Day01 do
  def part_1 do
    input = AdventOfCode.getInput("https://adventofcode.com/2024/day/1/input", "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")

    {first, second} = parse(input)

    Enum.zip([Enum.sort(first), Enum.sort(second)])
    |> Enum.reduce(0 ,fn {left, right}, acc -> abs(left - right) + acc end)
    |> IO.puts
  end

  def part_2 do
    input = AdventOfCode.getInput("https://adventofcode.com/2024/day/1/input", "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")

    {first, second} = parse(input)

    frequencies = Enum.frequencies(second)
    Enum.reduce(first, 0, fn element, acc -> (element * Map.get(frequencies, element, 0)) + acc end)
    |> IO.puts
  end

  defp parse(input) do 
    input 
    |> String.split("\n") 
    |> Enum.map(fn line -> 
      {first, line} = Integer.parse(line)
      line = String.trim(line)
      {second, ""} = Integer.parse(line)
      {first, second}
    end)
    |> Enum.unzip
  end
end
