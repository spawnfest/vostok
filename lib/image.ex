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

  defp add_to_chunk(position, pixel) do

  end

  defp get_pixels(path) do
    [_ | stream] = File.stream(path)
    my_map = {}
    Enum.each(stream, fn(file_row) ->
      splitted_file_row = String.split(file_row)
      [position | _] = splitted_file_row[0]
      color = String.slice(splitted_file_row[3], 5..-2)
      [r, g, b] = String.split(color, ",")
      )
      # ci calcoliamo in anticipo i gruppi in cui vogliamo
      # seprare i pixel
      # ad ogni giro piuttosto che farci le seghe sulle
      # datastructures ficchiamo i pixel nel proprio gruppo
  end

  defp build_map(my_map, file_row) do
    # 0,0: (22389,36247,47558)  #578DB9  srgb(87,141,185)

  end
end