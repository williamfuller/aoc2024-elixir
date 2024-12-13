defmodule Day07 do
  @operators_part_1 [:mul, :plus]
  @operators_part_2 [:mul, :plus, :cat]

  def part_1() do
    input()
    |> Enum.filter(fn {target, [first | rest]} ->
      Enum.any?(maths([first], rest, @operators_part_1), fn x -> x == target end)
    end)
    |> Enum.reduce(0, fn {target, _}, acc -> acc + target end)
  end

  def part_2() do
    input()
    |> Enum.filter(fn {target, [first | rest]} ->
      Enum.any?(maths([first], rest, @operators_part_2), fn x -> x == target end)
    end)
    |> Enum.reduce(0, fn {target, _}, acc -> acc + target end)
  end

  # IO
  defp input() do
    AOC.get_input(
      7,
      "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a"
    )
    |> parse
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ":", trim: true))
    |> Enum.map(fn [target, options] ->
      {String.to_integer(target),
       String.split(options, " ", trim: true) |> Enum.map(&String.to_integer(&1))}
    end)
  end

  # logic
  defp maths(acc, [], _) do
    acc
  end

  defp maths(acc, [current | rest], operators) do
    operators
    |> Enum.flat_map(fn operator ->
      acc
      |> Enum.map(fn j ->
        case operator do
          :mul -> j * current
          :plus -> j + current
          :cat -> "#{j}#{current}" |> String.to_integer()
        end
      end)
    end)
    |> maths(rest, operators)
  end
end
