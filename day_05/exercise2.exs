
File.stream!("input")
|> Stream.filter(fn(str) ->
	Regex.match?(~r/(..).*\1/, str)
	and 
	Regex.match?(~r/(.).\1/, str)
end)
|> Enum.to_list
|> Enum.count
|> IO.puts
