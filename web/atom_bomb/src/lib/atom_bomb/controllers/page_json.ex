defmodule AtomBomb.PageJSON do
  def bomb(%{bomb: bomb}) do
    %{
      location: bomb.location,
      power: bomb.power,
      altitude: bomb.altitude,
      explosion_type: bomb.explosion_type,
    }
  end

  def danger_level(%{danger_message: danger_message}) do
    %{
      message: danger_message,
    }
  end
end
