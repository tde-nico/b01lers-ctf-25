defmodule AtomBomb.ErrorJSON do
  # show exception message to user when exception occurs
  def render("500.json", params) do
    %{
      error: Exception.message(params.reason)
    }
  end
end
