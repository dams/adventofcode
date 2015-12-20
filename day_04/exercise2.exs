defmodule Exercise1 do

	def compute(input) do
		compute(input, nil, 0)
	end

	def compute(_input, "000000" <> _md5_rest, nb) do
		nb
	end

	def compute(input, _md5, nb) do
		compute(input, :crypto.hash(:md5, input <> to_string(nb+1)) |> Base.encode16, nb + 1)
	end

end

input = "ckczppom"
IO.puts Exercise1.compute(input)
