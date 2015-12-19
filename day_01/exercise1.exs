defmodule Exercise1 do
	def walk(input) do
		walk(input, 0)
	end

	def walk(<<"(", rest :: binary>>, acc) do
		walk(rest, acc+1)
	end

	def walk(<<")", rest :: binary>>, acc) do
		walk(rest, acc-1)
	end

	def walk("", acc) do
		acc
	end
end

input = File.read! "input"
IO.puts Exercise1.walk(input)
