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

      iex> structure = %Structure{node: :err, keys: [:code, :message]}
      iex> message = "Bad response!"
      iex> Formatter.format(structure, __ENV__, :bad_response, message)
      %{err: %{code: :bad_response, message: "Bad response!"}}

      iex> structure = %Structure{keys: [:code, :message]}
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

  defp format_code(params, structure, value),
  do: format_entry(params, structure, :code, value)

  defp format_entry(params, structure, key, value) when is_atom(key) do
    if structure.keys |> List.wrap |> Enum.member?(key) do
      new_key = String.to_atom(to_string(structure.prefix) <> to_string(key))

      Map.put(params, new_key, value)
    else
      params
    end
  end

  defp format_env_values(params, structure, env) do
    Enum.reduce(@env_keys, params,
      &format_entry(&2, structure, &1, Map.get(env, &1)))
  end

  defp format_message(params, structure, value),
  do: format_entry(params, structure, :message, value)
end
