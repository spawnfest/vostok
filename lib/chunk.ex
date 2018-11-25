defmodule Chunk do
  @moduledoc """
  Chunk execute color average on a set of pixels asynchronously.

  Chunk can run color average on a set of pixel either synchronously or
  asynchronously. After processing is complete, a message is sent to the
  specified mailbox to allow further processing.
  """

  @doc """
  start spawn a separate process where init function is run

  ## Examples
  chunk = {"1", [[0,0,0],[255,255,255]]}
  pid = Chunk.start(chunk, self())
  """
  @spec start(any(), pid()) :: pid()
  def start(chunk, pipeline_pid) do
    spawn(__MODULE__, :init, [chunk, pipeline_pid])
  end

  @doc """
  init performs color averaging on the specified chunk

  ## Examples
  chunk = {"1", [[0,0,0],[255,255,255]]}
  Chunk.init(chunk, self())
  """
  @spec init(any(), pid()) :: any()
  def init(chunk, pipeline_pid) do
    {id, colors} = chunk
    {:ok, pixel} = ColorAverage.run(colors)
    send(pipeline_pid, {:ok , {id, pixel}})
  end
end
