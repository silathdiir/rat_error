use Mix.Config

config :rat_error, RatError.Structure,
  node: :error,
  keys: %{
    code: :code,
    message: :message
  }
