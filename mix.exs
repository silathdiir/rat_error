defmodule RatError.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rat_error,
      version: "0.0.1",
      elixir: "~> 1.5",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Rat Error",
      source_url: "https://github.com/silathdiir/rat_error"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo,  "~> 0.5",   only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
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
