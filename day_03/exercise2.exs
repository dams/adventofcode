defmodule Exercise1 do
	def parse(input) do
		parse_santa(input, {0,0}, {0,0}, %{ "0x0" => 1 } )
	end

	def parse_santa("", _, _, dict) do
		dict |> Dict.keys |> Enum.count
	end

	def parse_santa(input, santa, robo_santa, dict) do
		{ rest, new_santa } = new_pos(input, santa)
		parse_robo_santa(rest, new_santa, robo_santa, Dict.put_new(dict, gen_key(new_santa), 1))
	end

	def parse_robo_santa("", _, _, dict) do
		dict |> Dict.keys |> Enum.count
	end

	def parse_robo_santa(input, santa, robo_santa, dict) do
		{ rest, new_robo_santa } = new_pos(input, robo_santa)
		parse_santa(rest, santa, new_robo_santa, Dict.put_new(dict, gen_key(new_robo_santa), 1))
	end

	def gen_key({x,y}) do
		to_string(x) <> "x" <> to_string(y)
	end

	def new_pos("<" <> rest, {x, y}) do { rest, {x-1, y} } end
	def new_pos(">" <> rest, {x, y}) do { rest, {x+1, y} } end
	def new_pos("^" <> rest, {x, y}) do { rest, {x, y-1} } end
	def new_pos("v" <> rest, {x, y}) do { rest, {x, y+1} } end
end

input = File.read! "input"
IO.puts Exercise1.parse(input)
