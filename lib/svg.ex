defmodule Svg do
  def render(pixels, output_size) do
    rects = Enum.map(pixels, fn pixel ->
      rect(pixel)
    end)
    svg = [header(output_size)] ++ rects ++ [footer]
    Enum.join(svg, "\n")
  end

  defp header(output_size) do
    "<svg viewbox='0 0 #{output_size} #{output_size}' xmlns='https://www.w3.org/2000/svg'>"
  end

  defp footer, do: "</svg>"

  defp rect(pixel) do
    {{x, y}, {r, g, b}} = pixel
    "<rect x='#{x}' y='#{y}' width='1' height='1' fill='rgb(#{r},#{g},#{b})'/>"
  end
end