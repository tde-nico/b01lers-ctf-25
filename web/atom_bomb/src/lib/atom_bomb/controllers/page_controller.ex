defmodule AtomBomb.PageController do
  use Phoenix.Controller, formats: [:json]

  import Plug.Conn

  def home(conn, _params) do
    redirect(conn, to: "/page.html")
  end

  def get_atom_bomb(conn, _params) do
    render(conn, :bomb, bomb: AtomBomb.get_bomb())
  end

  def get_bomb_impacts(conn, params) do
    params = AtomBomb.atomizer(params)

    danger_message = AtomBomb.calculate_bomb_danger_level(params.impact.bomb)

    render(conn, :danger_level, danger_message: danger_message)
  end
end
