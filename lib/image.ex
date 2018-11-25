defmodule Image do
  def start(path, pipeline_pid) do
    spawn(__MODULE__, :init, [path, pipeline_pid])
  end

  def init(path, pipeline_pid) do
    Mogrify.open(path)
      |> Mogrify.gravity("center")
      |> Mogrify.resize_to_fill("480x480")
      |> Mogrify.format("txt")
      |> Mogrify.save()
      |> Map.get(:path)
      |> get_pixels()
      |> send_message(pipeline_pid)
  end

  defp send_message(nil, pipeline_pid), do: send(pipeline_pid, {:error, "No path found!"})
  defp send_message(chunks, pipeline_pid), do: send(pipeline_pid, {:ok, chunks})

  defp get_pixels(nil), do: nil

  defp get_pixels(path) do
    my_map = %{}
    [w, h] = [480, 480]
    output = 32
    chunk_numbers = div(w, output)
    chunk_w = div(w, chunk_numbers)
    chunk_h = div(h, chunk_numbers)
    stream =
      File.stream!(path)
        |> Stream.drop(1)
        |> Enum.map(fn(file_row) ->
          # 0,0: (22389,36247,47558)  #578DB9  srgb(87,141,185)
          [pos, _, _, pixel] = String.split(String.strip(file_row))
          position = String.slice(pos, 0..-2)
          [x, y] = String.split(position, ",")
                  |> Enum.map(fn(c) -> String.to_integer(c) end)

          color = String.slice(pixel, 5..-2)
                  |> String.split(",")
                  |> Enum.map(fn(c) -> String.to_integer(c) end)

          chunk_id = {div(x, chunk_w), div(y, chunk_h)}
          {chunk_id, color}
        end)
        |> Enum.group_by(
          (fn r -> {key, _} = r; key end),
          (fn r -> {_, value} = r; value end)
        )
  end
end