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

    Pipeline.start(path, self(), 480, 480, 32)

    receive do
      {:ok, _} -> IO.puts """
We did our best for your ugly pixelated low-res image!
"""
      {:error, message} -> IO.puts message
      other -> raise "Me not like that: #{other}"
    end
  end

  def main(args) do
    {path} = parse_args(args)
    # IO.inspect(path)
    start(path)
  end

  defp help do
    IO.puts """
Pixelate the specified image. All hail, pixels!

Usage:
  vostok <path>
  vostok --help

Parameters:
  path         The path to the image to convert

Options:
  --help       Show this screen
"""

  end

  defp parse_args(args) do
    parsed = OptionParser.parse(args,
        strict: [
            help: :boolean
        ],
        aliases: []
    )

    case parsed do
      {_, [path], _} ->
        {path}
      _ ->
        help()
        exit(:shutdown)
    end
  end
end
