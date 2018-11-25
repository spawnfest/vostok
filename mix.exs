defmodule Vostok.MixProject do
  use Mix.Project

  def project do
    [
      app: :vostok,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Vostok],
      deps: deps(),
      package: package(),
      homepage_url: "https://dev.welaika.com",
      source_url: "https://github.com/spawnfest/vostok",
      description: "Vostok converts an image to a pixelated SVG",
      docs: [
        main: "Vostok",
        logo: "static/vostok_logo_white.png",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mogrify, "~> 0.6.1"}
    ]
  end

  defp package() do
    [
      name: "vostok",
      organization: "welaika",
      files: ~w(lib config static mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/spawnfest/vostok"}
    ]
  end
end
