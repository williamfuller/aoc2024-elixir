defmodule AOC do
	def getinput(day, cookie) do 
		:httpc.request(:get, {~c"https://adventofcode.com/2024/day/#{day}/input", [{~c"Cookie", cookie}]}, [], [])
	end
end
