# Rat Error

[![Build Status](https://travis-ci.org/silathdiir/rat_error.svg?branch=master)](https://travis-ci.org/silathdiir/rat_error)

Provides helper functions for error handling:

* detailed error description.
* default and configurable error fields.

## Installation

```elixir
def deps do
  [
    {:rat_error, "~> 0.0.2"}
  ]
end
```

## Usage

Calls `use RatError` in the specified `TestModule`.

```elixir
defmodule TestModule do
  use RatError
  require Logger

  def fun do
    with {:ok, _} <- bar() do

      # Some logic here ...

    else
      {:error, error} = error_result ->
        # Logs the error details.
        error |> inspect() |> Logger.error()

        # Returns the error.
        error_result
    end
  end

  defp bar, do: {:error, rat_error("some_error_code", "Some Error Message.")}
end
```

The `error` is formatted as below.

```elixir
%{
  code: "some_error_code",
  file: ".../lib/test_module.ex",
  function: {:bar, 0},
  line: 18,
  message: "Some Error Message.",
  module: TestModule
}
```

## Configuration

```elixir
config :rat_error, RatError.Structure,
  # Node Name
  #
  # The node is removed if key `node` is not existing or value is nil. Error
  # fields are exposed outside, and the below configuration `keys` must be set
  # to distinguish with other caller's keys.
  node: :err,

  # So the structure should be,
  #
  # %{
  #   err:
  #   %{
  #     code:     :invalid_argument,
  #     file:     "/home/dummy/my_app/web/user_controller.ex",
  #     function: {:authenticate, 1},
  #     line:     123,
  #     message:  "wrong token!",
  #     module:   Elixir.MyApp.Registration.UserController
  #   }
  # }

  # Support Key Mapping
  #
  # This Map must be set with the original fields (as Map keys). Map keys are
  # original fields (see the below description for detail). Map values are
  # custom field names (for formatting, they could be the same atoms as keys).
  # The field is ignored if key is not existing or value is nil.
  keys:
  %{
    # Error code defined by caller, e.g. an atom :no_entry, an integer 9 or a
    # string "unexpected".
    code: :err_code,

    # Error file path.
    file: :file,

    # Error function name.
    function: :function,

    # Error file line.
    line: :line,

    # Error message of string passed in by caller.
    message: :err_msg,

    # Error module.
    module: :module
  }

  # So the structure should be,
  #
  # %{
  #   err:
  #   %{
  #     err_code: :invalid_argument,
  #     err_msg:  "wrong token!",
  #     file:     "/home/dummy/my_app/web/user_controller.ex",
  #     function: {:authenticate, 1},
  #     line:     123,
  #     module:   Elixir.MyApp.Registration.UserController
  #   }
  # }
```
