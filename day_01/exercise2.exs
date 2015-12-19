defmodule Exercise2 do
	def walk(input) do
		walk(input, 0, 1)
	end

	def walk(_, -1, string_pos) do
		string_pos-1
	end

	def walk(<<"(", rest :: binary>>, floor_nb, string_pos) do
		walk(rest, floor_nb+1, string_pos+1)
	end

	def walk(<<")", rest :: binary>>, floor_nb, string_pos) do
		walk(rest, floor_nb-1, string_pos+1)
	end

	def walk("", _floor_nb, _string_pos) do
		raise "never went to the basement"
	end

end

input = File.read! "input"
IO.puts is_binary(input)
IO.puts Exercise2.walk(input)
