defmodule VostokTest do
  use ExUnit.Case
  doctest Vostok

  test "greets the world" do
    assert Vostok.hello() == :world
  end
end
