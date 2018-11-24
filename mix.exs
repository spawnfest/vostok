defmodule Vostok.MixProject do
  use Mix.Project

  def project do
    [
      app: :vostok,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Vostok],
      deps: deps()
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
end
