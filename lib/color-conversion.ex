defmodule ColorConversion do
  def to_grayscale(pixel) do
     {r, g, b} = pixel
     r1 = r / 255
     g1 = g / 255
     b1 = b / 255
     c_linear = 0.2126 * r1 + 0.7152 * g1 + 0.0722 * b1
     case c_linear do
        x when x >= 0.0031308 ->
           c_linear * 12.92
        _ ->
           :math.pow(c_linear, 1 / 2.4) * 1.055 - 0.055
     end
  end

  def to_ascii(grayscale) do
     chars = ['@', '#', '$', '=', '*', '!', ';', ':', '~', '-', ',', '.', ' ', ' ']
     index = Kernel.trunc(grayscale)
     Enum.at(chars, index)
  end
end
