defmodule Vostok do
  @moduledoc """
  Documentation for Vostok.
  """

  def print_ascii(chunks) do
    Enum.sort(chunks, fn e1, e2 ->
      e1 < e2
    end)
    |> Enum.map(fn pixel ->
      {{x, y}, rgb} = pixel
      {{x, y}, ColorConversion.to_grayscale(rgb)}
    end)
    |> Enum.group_by(
      (fn r -> {{_, key}, _} = r; key end),
      (fn r -> {_, value} = r; value end)
    )
    |> Enum.map(fn row ->
      {_, pixels} = row
      Enum.map(pixels, fn pixel ->
        ColorConversion.to_ascii(pixel)
      end)
      |> Enum.join("")
    end)
    |> Enum.each(fn row ->
      IO.puts row
    end)
  end

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
      {:ok, chunks} ->
         print_ascii(chunks)
      {:error, message} -> IO.puts message
      _ -> raise "No paghi wi-fi"
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
