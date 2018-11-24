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

    image =
      Mogrify.open(path)
      |> Mogrify.format("txt")
      |> Mogrify.save()

    IO.inspect(image)

    # IO.inspect	 img

    send(vostok_pid, {:ok, true})
  end
end
