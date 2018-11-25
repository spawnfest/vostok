defmodule Chunk do
  def start(chunk, pipeline_pid) do
    spawn(__MODULE__, :init, [chunk, pipeline_pid])
  end

  def init(chunk, pipeline_pid) do
    {id, colors} = chunk
    {:ok, pixel} = ColorAverage.run(colors)
    send(pipeline_pid, {:ok , {id, pixel}})
  end
end