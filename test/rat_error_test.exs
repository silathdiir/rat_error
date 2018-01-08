defmodule RatErrorTest do
  use ExUnit.Case
  use RatError
  doctest RatError

  test "checks error with default configuration" do
    expected_result = %{
      error: %{
        code:     :invalid_argument,
        file:     "rat_error_test.exs",
        function: {:rat_error_fun, 2},
        line:     9,
        message:  "Invalid argument 'user'!",
        module:   RatErrorTest
      }
    }

    opts = %{
      node: :error,

      keys: %{
        code:     :code,
        file:     :file,
        function: :function,
        line:     :line,
        message:  :message,
        module:   :module
      }
    }

    result = rat_error_fun("user", opts)

    # retrieves the last component of the path.
    file  = Path.basename(result.error.file)
    error = %{result.error | file: file}

    result = %{result | error: error}

    assert result == expected_result
  end

  test "checks error with null node" do
    expected_result = %{
      code:     :invalid_argument,
      file:     "rat_error_test.exs",
      function: {:rat_error_fun, 2},
      line:     9,
      message:  "Invalid argument 'user'!",
      module:   RatErrorTest
    }

    opts = %{
      # Removes key 'node'.

      keys: %{
        code:     :code,
        file:     :file,
        function: :function,
        line:     :line,
        message:  :message,
        module:   :module
      }
    }

    result = rat_error_fun("user", opts)

    # retrieves the last component of the path.
    file  = Path.basename(result.error.file)
    error = %{result.error | file: file}

    result = %{result | error: error}

    assert result == expected_result
  end

  test "checks error with null node and custom keys" do
    expected_result = %{
      err_code: :invalid_argument,
      err_msg:  "Invalid argument 'user'!"
    }

    opts = %{
      keys: %{
        code:     :err_code,
        message:  :err_msg
      }
    }

    result = rat_error_fun("user", opts)

    assert result == expected_result
  end

  defp rat_error_fun(invalid_arg, opts \\ []) do
    message = "Invalid argument '#{inspect(invalid_arg)}'!"

    rat_error(:invalid_argument, message, opts)
  end
end
