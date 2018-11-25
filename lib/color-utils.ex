defmodule Color.Utils do
  def hex_to_rgb(hex) do
    String.replace(hex, "#", "")
    |> String.to_charlist()
    |> Enum.chunk_every(2)
    |> Enum.map(fn x -> List.to_string(x) |> String.to_integer(16) end)
  end
end
