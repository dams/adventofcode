defmodule Exercise2 do
	def loop(lines) do
		loop(lines, 0)
	end
	def loop([ line | tail], surface) do
		
		[x,y,z] = Enum.map( String.split(line, "x"), fn (e) -> { i, ""} = Integer.parse(e); i end )
		loop(tail, surface + 2*x*y + 2*y*z + 2*z*x + Enum.min([x*y,y*z,z*x]))
	end

	def loop([ ], surface) do
		surface
	end
end

input = File.read! "input"
IO.puts Exercise2.loop(String.split(input))
