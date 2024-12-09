defmodule Day05 do

def part_1() do 
  {instructions, updates} = input()
  IO.inspect {instructions, updates}
end

# IO
defp input() do 
  AOC.get_input(5, "session=53616c7465645f5f34803e22ae54be6575342af046e5b0b08fdc88699267a1f0f2700846ff857646bbe27fd78ce33e73cbd840cf32eba4508ea9dc81510eee5a")
  |> parse
end

defp parse(input) do
   [instructions, updates] = String.split(input, "\n\n") |> Enum.map(&String.split(&1, "\n"))

   {Enum.map(instructions, &String.split(&1,"|")), Enum.map(updates, &String.split(&1,","))}
end

end
