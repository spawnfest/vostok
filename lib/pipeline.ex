defmodule Pipeline do
  def start(path, vostok_pid) do
    spawn(__MODULE__, :init, [path, vostok_pid])
  end

  def init(path, vostok_pid) do
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
    Image.start(path, self())
    loop(vostok_pid)
  end

  def loop(vostok_pid) do
    receive do
      {:ok, path} -> send(vostok_pid, {:ok, path})
      {:error, message} -> send(vostok_pid, {:error, message})
      _ -> send(vostok_pid, {:error, "Something went wrong!"})
    end
  end
end
