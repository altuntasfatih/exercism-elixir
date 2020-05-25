defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }
  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    ((score - 10) / 2)
    |> :math.floor()
    |> trunc()
  end

  @spec ability :: pos_integer()
  def ability do
    rand = fn ->
      [h | _] = Enum.take_random([1, 2, 3, 4, 5, 6], 1)
      h
    end

    [rand.(), rand.(), rand.(), rand.()]
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    ch =
      %DndCharacter{}
      |> Map.put(:charisma, ability())
      |> Map.put(:dexterity, ability())
      |> Map.put(:constitution, ability())
      |> Map.put(:intelligence, ability())
      |> Map.put(:strength, ability())
      |> Map.put(:wisdom, ability())

    Map.put(ch, :hitpoints, 10 + modifier(ch.constitution))
  end
end
