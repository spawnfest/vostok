defmodule ColorAverageTest do
	use ExUnit.Case
	doctest ColorAverage

	test "average pixels" do
		{_, {red,green,blue}} = ColorAverage.run([{0,255,255},{0,255,255},{0,0,255}])
		assert red == 0
		assert green == 208
		assert blue == 255
	end
end
