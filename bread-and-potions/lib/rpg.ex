defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%RPG.LoafOfBread{}, %RPG.Character{health: health} = character) do
      {nil, %{character | health: health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%RPG.ManaPotion{strength: strength}, %RPG.Character{mana: mana} = character) do
      {%RPG.EmptyBottle{}, %{character | mana: mana + strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%RPG.Poison{}, %RPG.Character{} = character) do
      {%RPG.EmptyBottle{}, %{character | health: 0}}
    end
  end
end
