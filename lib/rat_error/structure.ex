defmodule RatError.Structure do
  @moduledoc """
  Specifies the Map structure of a RAT error.

  This struct could be created from the specified options as below,

  [
    node: :error,
    keys: %{
      code: :code,
      message: :message
    }
  ]

  References the 'RatError.Structure' configuration in 'config/*.exs' for
  detail.
  """

  alias __MODULE__
  require Logger

  defstruct [:node, :keys]

  @support_fields [
    # Error code defined by caller, e.g. an atom :no_entry, an integer 9 or a
    # string "unexpected".
    :code,

    # Error file path.
    :file,

    # Error function name.
    :function,

    # Error file line.
    :line,

    # Error message of string passed in by caller.
    :message,

    # Error module.
    :module
  ]

  @doc """
  Creates the struct from the default 'RatError.Structure' configuration.

  The default configuration is set in 'config/*.exs'.

  ## Examples

  References 'config/test.exs' for the test configuration.

      iex> Structure.create_from_default_config
      %RatError.Structure{
        node: :error,
        keys: %{
          code: :code,
          file: :file,
          function: :function,
          line: :line,
          message: :message,
          module: :module
        }
      }

  """
  def create_from_default_config do
    :rat_error
    |> Application.get_env(RatError.Structure)
    |> create
  end

  @doc """
  Creates the struct from the specified options.

  ## Examples

      iex> support_keys = %{code: :code, message: :message}
      iex> Structure.create(node: :err, keys: support_keys)
      %RatError.Structure{
        node: :err,
        keys: %{
          code: :code,
          message: :message
        }
      }

      iex> support_keys = %{code: :code, message: :message}
      iex> Structure.create(keys: support_keys)
      %RatError.Structure{
        node: nil,
        keys: %{
          code: :code,
          message: :message
        }
      }

      iex> Structure.create(keys: %{code: :code})
      %RatError.Structure{
        node: nil,
        keys: %{code: :code}
      }

  """
  def create(opts) when is_list(opts) do
    keys = filter_keys(opts[:keys])

    %Structure{node: opts[:node], keys: keys}
  end

  @doc """
  Updates the struct with the specified options.

  ## Examples

      iex> structure = %Structure{node: :error, keys: %{code: :code}}
      iex> Structure.update(structure, node: :err, keys: %{message: :message})
      %RatError.Structure{
        node: :err,
        keys: %{message: :message}
      }

  """
  def update(%Structure{} = structure, opts) when is_list(opts) do
    params =
      Enum.reduce([:node, :keys], %{}, fn k, acc ->
        case Keyword.fetch(opts, k) do
          {:ok, v} -> Map.put(acc, k, v)
          :error -> acc
        end
      end)

    params =
      if keys = params[:keys] do
        %{params | keys: filter_keys(keys)}
      else
        params
      end

    Map.merge(structure, params)
  end

  defp filter_keys(nil), do: nil

  defp filter_keys(keys) when is_map(keys) do
    fields = Map.keys(keys)
    filtered_fields = fields -- fields -- @support_fields

    if is_nil(List.first(filtered_fields)) do
      Logger.warn("there is no support keys - '#{inspect(keys)}'!")
    end

    Map.take(keys, filtered_fields)
  end
end
