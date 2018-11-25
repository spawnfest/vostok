defmodule Pipeline do
  def start(path, vostok_pid, width, height, output_size) do
    spawn(__MODULE__, :init, [path, vostok_pid, width, height, output_size])
  end

  def init(path, vostok_pid, width, height, output_size) do
    _ = """
    read image from FS
    	-> resize
    	-> crop
    	-> image to matrix => https://paste.ubuntu.com/p/b767cXcC7m/
    		# ImageMagick pixel enumeration: 500,500,255,srgba
    		0,0: (36,41,46,1)  #24292E  srgba(36,41,46,1)
    		1,0: (36,41,46,1)  #24292E  srgba(36,41,46,1)
    	-> split chunks ( keep x,y positions! )
    		-> calculate average
    	-> reconstruct chunk matrix
    	-> save chunks to "image"
    	-> showtime!
    """
    Image.start(path, self(), width, height, output_size)
    receive do
      {:ok, chunks} ->
        total_chunks = Enum.count(chunks)
        Enum.each(chunks, fn chunk ->
          Chunk.start(chunk, self())
        end)
        loop(vostok_pid, total_chunks, [], output_size)
      {:error, message} -> send(vostok_pid, {:error, message})
      other -> send(vostok_pid, {:error, "Something went wrong: #{other}"})
    end
  end

  def loop(vostok_pid, total_chunks, acc, output_size) do
    receive do
      {:ok, chunk} ->
        chunks = acc ++ [chunk]
        size = :math.pow(output_size, 2)
        cond do
          Enum.count(chunks) == size ->
            output_path = "#{Path.dirname(__ENV__.file)}/../static/pixelated-image.svg"
            {:ok, file} = File.open(output_path, [:write])
            IO.binwrite file, Svg.render(chunks, output_size)
            File.close file

            case :os.type() do
              {:unix, :darwin} ->
                System.cmd("open", ["static/index.html"])
                IO.puts "Look at your browser now!"
              {:unix, _} ->
                System.cmd("xdg-open", ["static/index.html"])
                IO.puts "Look at your browser now!"
              _ ->
                IO.puts "Open `static/index.html` in your browser"
            end
            send(vostok_pid, {:ok, chunks})
          true -> loop(vostok_pid, total_chunks, chunks, output_size)
        end
      _ -> send(vostok_pid, {:error, "Something went wrong!"})
    end
  end
end
