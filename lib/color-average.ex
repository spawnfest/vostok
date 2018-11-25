defmodule ColorAverage do

	def run(pixels) do
		red = average_red_channel_from pixels
		green = average_green_channel_from pixels
		blue = average_blue_channel_from pixels

		{:ok, {red,green,blue}}
	end

	defp average_red_channel_from(pixels) do
		Enum.map(pixels, fn({r,_,_}) -> r end) |> average_channel
	end

	defp average_green_channel_from(pixels) do
		Enum.map(pixels, fn({_,g,_}) -> g end) |> average_channel
	end

	defp average_blue_channel_from(pixels) do
		Enum.map(pixels, fn({_,_,b}) -> b end) |> average_channel
	end

	defp average_channel(colors) do
		# You need to first square the colors
		# 	then add them together
		# 	then take the square root
		Enum.map(colors, fn(x) -> :math.pow(x,2) end)
		|> Enum.reduce(0, fn(x, acc) -> acc + x end)
		|> trunc
		|> Integer.floor_div(length(colors))
		|> :math.sqrt
		|> Float.floor
	end
end
