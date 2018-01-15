defmodule RatErrorTest do
  use ExUnit.Case
  use RatError
  doctest RatError

  # Leaves this private function for the const 'line' value.
  defp rat_error_fun(invalid_value, opts) do
    message = "Invalid argument '#{invalid_value}'!"

    rat_error(:invalid_argument, message, opts)
  end

  test "checks error with default configuration" do
    expected_result = %{
      error: %{
        code: :invalid_argument,
        file: "rat_error_test.exs",
        function: {:rat_error_fun, 2},
        line: 10,
        message: "Invalid argument 'user'!",
        module: RatErrorTest
      }
    }

    opts = [
      node: :error,
      keys: %{
        code: :code,
        file: :file,
        function: :function,
        line: :line,
        message: :message,
        module: :module
      }
    ]

    result = rat_error_fun("user", opts)

    # retrieves the last component of the path.
    file  = Path.basename(result.error.file)

    error = %{result.error | file: file}
    result = %{result | error: error}
    assert result == expected_result
  end

  test "checks error with null node" do
    expected_result = %{
      code: :invalid_argument,
      file: "rat_error_test.exs",
      function: {:rat_error_fun, 2},
      line: 10,
      message: "Invalid argument 'user'!",
      module: RatErrorTest
    }

    opts = [
      node: nil,
      keys: %{
        code: :code,
        file: :file,
        function: :function,
        line: :line,
        message: :message,
        module: :module
      }
    ]

    result = rat_error_fun("user", opts)

    # retrieves the last component of the path.
    file  = Path.basename(result.file)

    result = %{result | file: file}
    assert result == expected_result
  end

  test "checks error with null node and custom keys" do
    expected_result = %{
      err_code: :invalid_argument,
      err_msg: "Invalid argument 'user'!"
    }

    opts = [
      node: nil,
      keys: %{
        code: :err_code,
        message: :err_msg
      }
    ]

    result = rat_error_fun("user", opts)
    assert result == expected_result
  end
end
