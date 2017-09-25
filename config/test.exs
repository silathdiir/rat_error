use Mix.Config

config :rat_error, RatError.Structure,
  node:   :error,
  prefix: nil,
  keys:
    [
      :code,
      :file,
      :function,
      :line,
      :message,
      :module
    ]
