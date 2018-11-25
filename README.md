![](https://github.com/spawnfest/vostok/blob/master/static/vostok_logo.png)
*since 1961*

# 🖼 Vostok

Vostok converts an image to a pixelated SVG.

[Восток][vostok] (*Vostok* in English) was the Russian spacecraft that in 1961
allowed the first human spaceflight. 🚀

[vostok]: https://en.wikipedia.org/wiki/Vostok_(spacecraft)

## Requirements

Vostok requires `imagemagick` to work.

Install it with:

**MacOSX**: `brew install imagemagick`

**Linux**: search your distribution repositories for `imagemagick` package;  
eg: `sudo apt install imagemagick`

**Windows**: Chocolatey has an `imagemagick` package, but no tests have been done :)

## Build

Vostok has been successfully built using `elixir 1.7.4` and `erlang 20.3.8.14`.
Has not been tested on different versions.

To build from command line:

```bash
$ # clone using HTTPS URL
$ git clone https://github.com/spawnfest/vostok.git && cd vostok
$ # clone using SSH URL
$ git clone git@github.com:spawnfest/vostok.git && cd vostok

```

Then install dependencies and build the CLI application:

```bash
$ mix deps.get
$ mix escript.build
```

## Usage

Vostok takes the path of the image to convert:

```bash
$ vostok path/to/the/image.jpg
```

Execute `vostok --help` to see usage and help.

Has been tested with `jpg` and `png` image formats, works probably with other formats
supported by ImageMagick.  

Once Vostok finishes processing the image, it tries to open you browser at
`static/index.html` to display it's work.  
In case this does not happen, manually open the `index.html` file in the `static`
folder of this repository with a recent browser.

## Testing

You can run the supplied test suite with:

```bash
$ mix test
```
