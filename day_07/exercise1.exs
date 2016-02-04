use Bitwise

defmodule Exercise1 do
	def loop(input) do
		loop(%{ }, input, [])
	end

	def loop(grid, [ ], [ ]) do
		grid
	end
	def loop(grid, [ ], acc) do
		loop(grid, Enum.reverse(acc), [])
	end
	def loop(grid, [ line | rest ], acc) do
		IO.puts(line)
		case parse(grid, line) do
			{ true, new_grid } -> loop(new_grid, rest, acc)
			_ -> loop(grid, rest, [ line | acc ]);
		end
	end

	def parse(grid, line) do
		[ operation, target ] =
		~r/(.+) -> (.+)/ |>
		Regex.run(line) |>
		Enum.drop(1)
		
	  apply_op(grid, operation, target)

  end

	def apply_op(grid, "NOT " <> var, target) do
		maybe_apply(grid, target, [var], fn() -> bnot(get_value(grid, var)) end)
	end

	def apply_op(grid, operation, target) do
		cond do
			match = Regex.run(~r/^(.+) (.+) (.+)$/, operation) ->
				compute(grid, target, Enum.drop(match, 1))
			true -> maybe_apply(grid, target, [operation], fn() -> get_value(grid, operation) end)
		end
	end

	def compute(grid, target, [ x, "AND", y])    do maybe_apply(grid, target, [x , y], fn() -> get_value(grid, x) &&& get_value(grid, y) end ) end
	def compute(grid, target, [ x, "OR", y])     do maybe_apply(grid, target, [x , y], fn() -> get_value(grid, x) ||| get_value(grid, y) end ) end
	def compute(grid, target, [ x, "LSHIFT", y]) do maybe_apply(grid, target, [x , y], fn() -> get_value(grid, x) <<< get_value(grid, y) end ) end
	def compute(grid, target, [ x, "RSHIFT", y]) do maybe_apply(grid, target, [x , y], fn() -> get_value(grid, x) >>> get_value(grid, y) end ) end

	def maybe_apply(grid, target, vars, f) do
		case Enum.all?(vars, fn(var) -> is_valid(grid, var) end) do 
			true -> { true, Map.put(grid, target, f.())}
			false -> false
		end
	end

	def is_valid(grid, x) do
		cond do
			x =~ ~r/^(\d+)$/ -> true
			true -> Map.has_key?(grid, x)
		end		
	end

	def get_value(grid, x) do
		cond do
			x =~ ~r/^(\d+)$/ -> String.to_integer(x)
			true -> Map.get(grid, x)
		end
	end

end

"input" |>
File.read! |>
String.split("\n") |>
Exercise1.loop |>
Map.get("a") |>
IO.inspect
