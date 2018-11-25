defmodule Color.UtilsTest do
  use ExUnit.Case
  doctest Color.Utils

  test "white color extraction" do
    out = Color.Utils.hex_to_rgb("#FFFFFF")
    assert out == [255, 255, 255]
  end

  test "black color extraction" do
    out = Color.Utils.hex_to_rgb("#000000")
    assert out == [0, 0, 0]
  end

  test "color extraction" do
    assert Color.Utils.hex_to_rgb("#454545") == [69, 69, 69]
    assert Color.Utils.hex_to_rgb("#C8C8C8") == [200, 200, 200]
  end
end
