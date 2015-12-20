defmodule Exercise1 do
	def parse(input) do
		parse(input, 0, 0, %{ "0x0" => 1 } )
	end

	def parse(">" <> rest, x, y, dict) do
		parse(rest, x+1, y, Dict.put_new(dict, gen_key(x+1, y), 1))
	end

	def parse("<" <> rest, x, y, dict) do
		parse(rest, x-1, y, Dict.put_new(dict, gen_key(x-1, y), 1))
	end

	def parse("^" <> rest, x, y, dict) do
		parse(rest, x, y-1, Dict.put_new(dict, gen_key(x, y-1), 1))
	end
	
	def parse("v" <> rest, x, y, dict) do
		parse(rest, x, y+1, Dict.put_new(dict, gen_key(x, y+1), 1))
	end

	def parse("", _x, _y, dict) do
		dict |> Dict.keys |> Enum.count
	end

	def gen_key(x,y) do
		to_string(x) <> "x" <> to_string(y)
	end
end

input = File.read! "input"
IO.puts Exercise1.parse(input)
