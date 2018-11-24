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
  defp send_message(pixel_list, pipeline_pid), do: send(pipeline_pid, {:ok, pixel_list})

  defp get_pixels(nil) do
    nil
  end

  defp get_pixels(path) do
    my_map = %{}
    [w, h] = [480, 480]
    output = 32
    chunk_numbers = w / output
    chunk_w = w / chunk_numbers
    chunk_h = h / chunk_numbers
    File.stream!(path)
    |> Stream.drop(1)
    |> Stream.map(fn(file_row) ->
      # 0,0: (22389,36247,47558)  #578DB9  srgb(87,141,185)
      [pos, _, _, pixel] = String.split(String.strip(file_row))
      position = String.slice(pos, 0..-2)
      [x, y] = String.split(position, ",") |>
        Enum.map(fn(c) -> String.to_integer(c) end)
      color = String.slice(pixel, 5..-2) |>
        String.split(",") |>
          Enum.map(fn(c) -> String.to_integer(c) end)
      chunk_id = {x / chunk_w, y / chunk_h}
      Map.update(my_map, chunk_id, [], fn v ->
        v ++ [color]
      end)
    end)
    |> Stream.run
    Enum.each(my_map, fn(x) -> IO.inspect(x) end)
    my_map
  end
end