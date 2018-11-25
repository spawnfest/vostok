defmodule ColorAverage do
  @moduledoc """
  ColorAverage averages colors in a 3 channel colored pixel.

  Starting from a tuple composed of {red,green,blue} integer values
  representing the red, green, blue channels in a RGB color, returns the
  average by channel of the colors.
  """

  @doc """
  Calculate color averaging on a set of pixels.

  ## Examples
  ColorAverage.run([{0,255,255},{0,255,255},{0,0,255}]) #=> {:ok, {0,208,255}}
  """
  @spec run(any()) :: map()
  def run(pixels) do
    red = average_red_channel_from pixels
    green = average_green_channel_from pixels
    blue = average_blue_channel_from pixels

    {:ok, {red,green,blue}}
  end

  defp average_red_channel_from(pixels) do
    Enum.map(pixels, fn([r,_,_]) -> r end) |> average_channel
  end

  defp average_green_channel_from(pixels) do
    Enum.map(pixels, fn([_,g,_]) -> g end) |> average_channel
  end

  defp average_blue_channel_from(pixels) do
    Enum.map(pixels, fn([_,_,b]) -> b end) |> average_channel
  end

  defp average_channel(colors) do
    # first square the colors
    Enum.map(colors, fn(x) -> :math.pow(x,2) end)
    # then add them together
    |> Enum.reduce(0, fn(x, acc) -> acc + x end)
    # convert to integer
    |> trunc
    |> Integer.floor_div(length(colors))
    # then take the square root
    |> :math.sqrt
    # ignore decimal values and return a rounded value
    |> Float.floor
    |> trunc
  end
end
