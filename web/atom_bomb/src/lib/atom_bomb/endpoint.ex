defmodule AtomBomb.Endpoint do
  use Phoenix.Endpoint, otp_app: :atom_bomb

  # Serve at "/" the static files from "priv/static" directory.
  plug Plug.Static,
    at: "/",
    from: :atom_bomb,
    gzip: false,
    only: ~w(page.html favicon.ico robots.txt images)

  plug Plug.RequestId

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug AtomBomb.Router
end
