
vowels = [ ?a, ?e, ?i, ?o, ?u]
bad_patterns = [ "ab", "cd", "pq", "xy" ]

File.stream!("input")
|> Stream.filter(fn(str) -> 
	count = String.to_char_list(str)
	|> Enum.count(fn(char) -> Enum.member?(vowels, char) end)
	count > 2
end)
|> Stream.filter(fn(str) ->
	Regex.match?(~r/(.)\1/, str)
end)
|> Stream.filter(fn(str) -> 
	not Enum.any?( bad_patterns, fn(pat) -> Regex.match?(~r/#{pat}/, str) end)
end)
|> Enum.to_list
|> Enum.count
|> IO.puts
