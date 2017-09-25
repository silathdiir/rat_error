defmodule RatError do
  @moduledoc File.read!("README.md")

  @doc false
  defmacro __using__(_) do
    quote location: :keep do

      # TODO: Load configuration 'RatError.Structure'.

      import RatError
    end
  end

  defmacro rat_error(error_code, opts \\ []) do
    quote location: :keep do
      file     = __ENV__.file
      function = __ENV__.function
      line     = __ENV__.line
      module   = __ENV__.module

      # TODO: fetch parameters from '__ENV__' and passed to format function.

    end
  end
end
