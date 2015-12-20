
bad_patterns = [ "ab", "cd", "pq", "xy" ]

File.stream!("input")
|> Stream.filter(fn(str) -> 
  Regex.match?(~r/(.*[aeiou].*){3}/, str)
	and
	Regex.match?(~r/(.)\1/, str)
	and
	Enum.all?( bad_patterns, fn(pat) -> not Regex.match?(~r/#{pat}/, str) end)
end)
|> Enum.to_list
|> Enum.count
|> IO.puts
