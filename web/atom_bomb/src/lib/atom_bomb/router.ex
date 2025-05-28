defmodule AtomBomb.Router do
  use Phoenix.Router, helpers: false

  import Plug.Conn
  import Phoenix.Controller

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AtomBomb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", AtomBomb do
    pipe_through :api

    get "/atom_bomb", PageController, :get_atom_bomb
    post "/bomb_impacts", PageController, :get_bomb_impacts
  end
end
