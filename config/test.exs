use Mix.Config

config :rat_error, RatError.Structure,
  node: :error,
  keys: %{
    code: :code,
    file: :file,
    function: :function,
    line: :line,
    message: :message,
    module: :module
  }
