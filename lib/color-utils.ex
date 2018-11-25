defmodule Color.Utils do
  @moduledoc """
  Color.Utils contains utility method for colours.
  """

  @doc """
  hex_to_rgb convert a colour in hex string representation, like #FFFFFF, into
  RGB representation (like [255,255,255])

  ## Examples
  Color.Utils.hex_to_rgb("#000000")
  """
  @spec hex_to_rgb(string()) :: list(pos_integer(), pos_integer(), pos_integer())
  def hex_to_rgb(hex) do
    String.replace(hex, "#", "")
    |> String.to_charlist()
    |> Enum.chunk_every(2)
    |> Enum.map(fn x -> List.to_string(x) |> String.to_integer(16) end)
  end
end
