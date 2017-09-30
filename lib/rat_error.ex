defmodule RatError do
  @moduledoc File.read!("README.md")

  alias RatError.{Formatter, Structure}

  @doc false
  defmacro __using__(opts \\ []) do
    quote(bind_quoted: [opts: opts], location: :keep) do
      structure =
        Structure.create_from_default_config
        |> Structure.update(opts)

      @structure structure

      import RatError
    end
  end

  @doc """
  Retrieves a RAT error with the specified parameters.

  This function is the main API of the plugin.

  Parameters 'error_code' and 'error_message' correspond to the support keys
  :code and :message (see 'config/*.exs' for detail). Both could be ignored by
  using the default values if keys :code and :message are disabled.

  Parameter 'opts' corresponds the Keyword configuration of 'RatError.Structure'
  (see 'config/*.exs' for detail). If this parameter is passed in, it merges
  with the configuration of 'RatError.Structure'.

  ## Examples

  Parameter 'opts' merges with the configuration in 'config/test.exs'.

  iex> opts = [keys: [:code, :message]]
  iex> rat_error(:wrong_password, "Wrong password!", opts)
  %{error: %{code: :wrong_password, message: "Wrong password!"}}

  """
  defmacro rat_error(error_code \\ nil, error_message \\ "", opts \\ []) do
    quote(bind_quoted: [error_code:    error_code,
                        error_message: error_message,
                        opts:          opts],
          location: :keep) do
      structure = Structure.update(@structure, opts)

      Formatter.format(structure, __ENV__, error_code, error_message)
    end
  end
end
