defmodule Image do
  def start(path, pipeline_pid, width, height, result) do
    spawn(__MODULE__, :init, [path, pipeline_pid, width, height, result])
  end

  def init(path, pipeline_pid, width, height, result) do
    crop_and_resize(path, width, height)
      |> Map.get(:path)
      |> get_pixels(width, height, result)
      |> send_message(pipeline_pid)
  end

  defp crop_and_resize(path, width, height) do
    image =
      Mogrify.open(path)
      |> Mogrify.gravity("center")
      |> Mogrify.resize_to_fill("#{width}x#{height}")

    # output in the static/ folder to serve from browser
    Mogrify.format(image, "jpg")
    |> Mogrify.save(path: "static/cropped.jpg")

    image
    |> Mogrify.format("txt")
    |> Mogrify.save()
  end

  defp get_pixels(path, width, height, result) do
    chunk_w = div(width, result)
    chunk_h = div(height, result)
    IO.puts "Reading image informations from: #{path}"
    File.stream!(path)
      |> Stream.drop(1)
      |> Enum.map(fn(file_row) ->
        # 0,0: (22389,36247,47558)  #578DB9  srgb(87,141,185)
        [pos, _, hex, _] = String.trim(file_row) |> String.split
        position = String.slice(pos, 0..-2)
        [x, y] = String.split(position, ",")
                |> Enum.map(fn(c) -> String.to_integer(c) end)

        color = Color.Utils.hex_to_rgb hex

        chunk_id = {div(x, chunk_w), div(y, chunk_h)}
        {chunk_id, color}
      end)
      |> Enum.group_by(
        (fn r -> {key, _} = r; key end),
        (fn r -> {_, value} = r; value end)
      )
  end

  defp send_message(nil, pipeline_pid), do: send(pipeline_pid, {:error, "No path found!"})
  defp send_message(chunks, pipeline_pid), do: send(pipeline_pid, {:ok, chunks})
end
