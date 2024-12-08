defmodule AOC do
  def get_input(day, cookie) do
    {_, {_, _, body}} =
      :httpc.request(
        :get,
        {~c"https://adventofcode.com/2024/day/#{day}/input", [{~c"Cookie", cookie}]},
        [],
        []
      )

    to_string(body)
  end
end
