defmodule RatError.Formatter do
  @moduledoc """
  Formats a RAT error.

  Formatter is used to retrieve the error Map result by formatting the
  parameters (error code, message, environment variables and so on) with the
  specified Structure (see 'config/*.exs' for detail).
  """

  alias RatError.Structure

  @env_keys [
    :file,
    :function,
    :line,
    :module
  ]

  @doc """
  Format a RAT error with the specified Structure.

  ## Examples

      iex> support_keys = %{code: :code, message: :message}
      iex> structure = %Structure{node: :err, keys: support_keys}
      iex> message = "Bad response!"
      iex> Formatter.format(structure, __ENV__, :bad_response, message)
      %{err: %{code: :bad_response, message: "Bad response!"}}

      iex> support_keys = %{code: :code, message: :message}
      iex> structure = %Structure{keys: support_keys}
      iex> message = "Out of memory!"
      iex> Formatter.format(structure, __ENV__, :no_memory, message)
      %{code: :no_memory, message: "Out of memory!"}

  """
  def format(%Structure{} = structure,
             %Macro.Env{} = env,
             error_code,
             error_message) do

    params =
      %{}
      |> format_code(structure, error_code)
      |> format_message(structure, error_message)
      |> format_env_values(structure, env)

    if node = structure.node do
      %{node => params}
    else
      params
    end
  end

  defp add_field(nil, _value, params), do: params
  defp add_field(key, value, params), do: Map.put(params, key, value)

  defp format_code(params, structure, value),
  do: format_entry(params, structure, :code, value)

  defp format_entry(params, structure, key, value) when is_atom(key) do
    structure.keys
    |> get_field_name(key)
    |> add_field(value, params)
  end

  defp format_env_values(params, structure, env) do
    Enum.reduce(@env_keys, params,
      &format_entry(&2, structure, &1, Map.get(env, &1)))
  end

  defp format_message(params, structure, value),
  do: format_entry(params, structure, :message, value)

  defp get_field_name(nil, _key), do: nil
  defp get_field_name(support_keys, key) when is_map(support_keys),
  do: support_keys[key]
end
