defmodule AtomBomb do
  def string_to_atom(string) do
    try do
      {:ok, String.to_existing_atom(string)}
    rescue
      # no atom for this string exists
      ArgumentError -> :error
    end
  end

  @doc """
  Converts params to atoms
  """
  def atomizer(params) when is_map(params) do
    Enum.map(params, fn {key, val} -> case string_to_atom(key) do
      {:ok, key} -> {key, atomizer(val)}
      :error -> nil
    end
    end)
    |> Enum.filter(fn val -> val != nil end)
    |> Map.new
  end

  def atomizer(params) when is_list(params) do
    Enum.map(params, &atomizer/1)
  end

  def atomizer(params) when is_binary(params) do
    if String.at(params, 0) == ":" do
      # convert string to atom if it starts with :
      # remove leading :
      atom_string = String.slice(params, 1..-1//1)

      case string_to_atom(atom_string) do
        {:ok, val} -> val
        :error -> nil
      end
    else
      params
    end
  end

  # any other value is left as is
  def atomizer(params) do
    params
  end

  # Possible altitudes the bomb can detonate at
  defp bomb_altitudes do
    [
      :underground,
      :surface,
      :low_altitude,
      :high_altitude,
      :space,
    ]
  end

  defp bomb_locations do
    [
      "ohio",
      "florida",
      "utah",
      "new york",
      "indiana",
      "quebec",
      "idaho",
      "arizona",
    ]
  end

  @doc """
  Gets the incoming bomb
  """
  def get_bomb() do
    %{
      power: Enum.random(1..1200),
      location: Enum.random(bomb_locations()),
      altitude: Enum.random(bomb_altitudes()),
      explosion_type: Enum.random(0..7),
    }
  end

  @doc """
  Calculates the danger level of the atom bomb for the given location
  """
  def calculate_bomb_danger_level(bomb) do
    scaling = case bomb.altitude do
      :underground -> 0.05
      :surface -> 1.5
      :low_altitude -> 3.0
      :high_altitude -> 1.2
      :space -> 0.03
    end

    power = scaling * bomb.power

    cond do
      power < 200.0 -> "there is not much danger"
      power < 400.0 -> "you might get cancer"
      power < 800.0 -> "you should hide underground"
      power < 1300.0 -> "your house will be blown away"
      true -> "you might be cooked"
    end
  end

  def bomb() do
    flag = case File.read("flag.txt") do
      {:ok, flag} -> flag
      {:error, _} -> "bctf{REDACTED}"
    end

    "The atom bomb detonated, and left in the crater there is a chunk of metal inscribed with #{flag}"
  end
end
