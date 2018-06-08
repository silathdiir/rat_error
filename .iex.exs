defmodule RatErrorIEX do
  use RatError

  def fun do
    rat_error("some_error_code", "Some Error Message.")
  end
end
