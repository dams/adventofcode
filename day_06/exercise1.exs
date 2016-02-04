defmodule Exercise1 do
	def loop(input) do
		loop(%{ }, input)
	end

	def loop(grid, [ ]) do grid end
	def loop(grid, [ line | rest ]) do
		IO.puts(line)
		grid |>
		parse(line) |>
		loop(rest)
	end

	def parse(grid, "turn on "  <> line) do parse(grid, line, &( { &1, 1 } ))  end
	def parse(grid, "turn off " <> line) do parse(grid, line, &( { &1, 0 } ))  end
	def parse(grid, "toggle "   <> line) do parse(grid, line, &( { &1, case &1 do 1 -> 0; _ -> 1 end } )) end

	def parse(grid, line, action) do
		[ x1, y1, x2, y2 ] = 
	  ~r/(\d+),(\d+) through (\d+),(\d+)/ |>
		Regex.run(line) |>
		Enum.drop(1) |>
	  Enum.map(&String.to_integer/1)

		List.foldl(Enum.to_list(x1..x2), grid,
		 	fn(x, grid) ->
				List.foldl(Enum.to_list(y1..y2), grid,
		 			fn(y, grid) ->
						key = (Integer.to_string(x) <> "x" <> Integer.to_string(y))
						{ _new_val, new_grid } =  Map.get_and_update(grid, key, action)
						new_grid
					end)
			end)
	end

end

"input" |>
File.read! |>
String.split("\n") |>
Exercise1.loop |>
Map.values |>
Enum.count(&(&1 == 1)) |>
IO.inspect
