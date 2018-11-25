defmodule ChunkTest do
  use ExUnit.Case
  doctest Chunk

  test "start spawn init" do
    chunk = {"1", [[0,0,0],[255,255,255]]}
    pid = Chunk.start(chunk, self())
    info = Process.info(pid)
    assert (info[:status] == :runnable || info[:status] == :running) == true
    assert_receive({:ok, {"1", {180, 180, 180}}}, 500)
  end

  test "init send resulting data" do
    chunk = {"1", [[0,0,0],[255,255,255]]}
    Chunk.init(chunk, self())
    assert_received({:ok, {"1", {180, 180, 180}}})
  end
end
