defmodule KitchenCalculator do
  def get_volume({_unit, volume}), do: volume

  def to_milliliter({unit, volume}), do: {:milliliter, milliliter(unit) * volume}

  def from_milliliter({:milliliter, volume}, target_unit),  do: {target_unit, volume / milliliter(target_unit)}

  def convert(volume_pair, target_unit), do: to_milliliter(volume_pair) |> from_milliliter(target_unit)

  defp milliliter(:milliliter), do: 1
  defp milliliter(:teaspoon), do: 5
  defp milliliter(:tablespoon), do: 15
  defp milliliter(:fluid_ounce), do: 30
  defp milliliter(:cup), do: 240
end
