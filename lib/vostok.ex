defmodule Vostok do
  @moduledoc """
  Documentation for Vostok.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Vostok.hello()
      :world

  """
  def start(path) do
    IO.puts "Working on #{path}"

    Pipeline.start(path, self())

    receive do
      {:ok, _} -> IO.puts "Did it work?"
      _ -> raise "Here bu dragons"
    end
  end

  def main(args) do
    {path} = parse_args(args)
    start(path)
  end

  defp help do
    IO.puts "vostok <path>"
    exit(1)
  end

  defp parse_args(args) do
    parsed = OptionParser.parse(args, strict: [])

    case parsed do
      {_, [path], _} -> {path}
      _ -> help()
    end
  end
end
