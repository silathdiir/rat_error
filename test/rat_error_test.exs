defmodule RatErrorTest do
  use ExUnit.Case
  use RatError
  doctest RatError

  defp rat_error_fun(invalid_arg, opts \\ []) do
    message = "Invalid argument '#{inspect(invalid_arg)}'!"

    rat_error(:invalid_argument, message, opts)
  end

  test "checks error with default configuration" do
    expected_result =
      %{
        error:
        %{
          code:     :invalid_argument,
          file:     "rat_error_test.exs",
          function: {:rat_error_fun, 2},
          line:     9,
          message:  "Invalid argument 'nil'!",
          module:   RatErrorTest
        }
      }

    real_result = rat_error_fun(nil)

    # retrieves the last component of the path.
    file  = Path.basename(real_result.error.file)
    error = %{real_result.error | file: file}

    real_result = %{real_result | error: error}

    assert expected_result == real_result
  end

  test "checks error with custom configuration" do
    expected_result =
      %{
        err_code:    :invalid_argument,
        err_message: "Invalid argument 'nil'!"
      }

    real_result =
      rat_error_fun(nil, node: nil, prefix: :err_, keys: [:code, :message])

    assert expected_result == real_result
  end
end
