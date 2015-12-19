defmodule Exercise2 do
	def loop(lines) do
		loop(lines, 0)
	end
	def loop([ line | tail], needed) do
		dimensions = line
		|> String.split("x")
		|> Enum.map( fn (e) -> { i, ""} = Integer.parse(e); i end )
		length = dimensions
		|> Enum.sort()
		|> Enum.slice(0..1)
		|> Enum.map(fn (e) -> 2 * e end)
		|> Enum.sum
		bow = List.foldl(dimensions, 1, fn (e, acc) -> e * acc end)
		loop(tail, needed + length + bow)
	end

	def loop([ ], surface) do
		surface
	end
end

input = File.read! "input"
IO.puts Exercise2.loop(String.split(input))
