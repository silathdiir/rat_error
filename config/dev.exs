use Mix.Config

config :rat_error, RatError.Structure,
  # Node Name, the default value is 'error'.
  #
  # If node is 'err', the structure is,
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
  #
  # If node is nil or an empty string, the node is removed. The fields are
  # exposed outside, and the below configuration 'prefix' could be set to
  # distinguish with other caller's keys.
  node: :error,

  # Field Prefix, the default value is nil (NO prefix).
  #
  # If node is nil and prefix is 'err_', the structure is,
  #
  # %{
  #   err_code:     :invalid_argument,
  #   err_file:     "/home/dummy/my_app/web/user_controller.ex",
  #   err_function: {:authenticate, 1},
  #   err_line:     123,
  #   err_message:  "wrong token!",
  #   err_module:   Elixir.MyApp.Registration.UserController
  # }
  #
  prefix: nil,

  # Support Keys
  keys:
  [
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
