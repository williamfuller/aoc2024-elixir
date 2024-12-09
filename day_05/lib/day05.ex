defmodule Day05 do

def part_1() do 
  {instructions, updates} = input()
  instructions = instruction_map(instructions)

  Enum.filter(updates, fn update -> 
    correct_order?(update, instructions)
  end)
  |> Enum.reduce(0, fn update, acc ->
      value =  Enum.at(update, div(length(update), 2))
      |> String.to_integer
      value + acc
    end)
end

def part_2() do 
  {instructions, updates} = parse("47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
")
  instructions = instruction_map(instructions)

  Enum.reject(updates, fn update -> 
    correct_order?(update, instructions)
  end)
end

# IO
defp input() do 
  AOC.get_input(5, "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")
  |> parse
end

defp parse(input) do
   [instructions, updates] = String.split(input, "\n\n", trim: true) |> Enum.map(&String.split(&1, "\n", trim: true))

   {Enum.map(instructions, &String.split(&1,"|", trim: true)), Enum.map(updates, &String.split(&1,",", trim: true))}
end

# logic
defp correct_order?([first | rest], instructions) do
  instruction = Map.get(instructions, first, MapSet.new())
  Enum.all?(rest, fn element -> !(MapSet.member?(instruction, element)) end) && correct_order?(rest, instructions)
end

defp correct_order?([], _) do
  true
end

defp instruction_map(instructions) do 
  Enum.reduce(instructions, %{}, fn [b, a], map -> 
    map 
    |> Map.update(a, MapSet.new([b]), &MapSet.put(&1, b))
  end)
end

end
