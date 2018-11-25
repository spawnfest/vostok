![](https://github.com/spawnfest/vostok/blob/master/static/vostok_logo.png)
# Vostok

Vostok converts an image to a 32x32 pixelated svg.

## Requirements

Vostok requires the following applications:

- `imagemagick`

## Build

```bash
$ mix deps.get
$ mix escript.build
```

## Usage

Vostok takes the path of the image to convert:

```bash
$ vostok <path>
```

Once it has finished processing the image it will open up the image in the browser.

## Testing

To run tests:

```bash
$ mix test
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `vostok` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:vostok, "~> 0.1.0"}
  ]
end
```

The docs may be found at [https://hexdocs.pm/vostok](https://hexdocs.pm/vostok).
