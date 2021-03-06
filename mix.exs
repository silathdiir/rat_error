defmodule RatError.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rat_error,
      version: "0.0.2",
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Rat Error",
      source_url: "https://github.com/silathdiir/rat_error",
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Helper functions for error handling"
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Steven Gu"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/silathdiir/rat_error"}
    ]
  end
end
