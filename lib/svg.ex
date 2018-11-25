defmodule Svg do
  def render(pixels, dimension, output_size) do
    scaling = dimension/output_size
    rects = Enum.map(pixels, fn pixel ->
      rect(pixel, scaling)
    end)
    svg = [header(output_size*scaling)] ++ rects ++ [footer()]
    Enum.join(svg, "\n")
  end

  defp header(output_size) do
    "<svg width='#{output_size}' height='#{output_size}' viewbox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'>"
  end

  defp footer, do: "</svg>"

  defp rect(pixel, scaling) do
    {{x, y}, {r, g, b}} = pixel
    "<rect x='#{x*scaling}' y='#{y*scaling}' width='#{1*scaling}' height='#{1*scaling}' fill='rgb(#{r},#{g},#{b})'/>"
  end
end
