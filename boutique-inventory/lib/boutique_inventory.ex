defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, &<=/2)
  end

  def with_missing_price(inventory), do: Enum.filter(inventory, &(&1.price == nil))

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item.name, old_word, new_word)}
    end)
  end

  def increase_quantity(%{quantity_by_size: quantity_by_size} = item, count) do
    %{
      item
      | quantity_by_size: Enum.into(quantity_by_size, %{}, fn {k, v} -> {k, v + count} end)
    }
  end

  def total_quantity(%{quantity_by_size: quantity_by_size}) do
    Enum.reduce(quantity_by_size, 0, fn {_, n}, acc -> acc + n end)
  end
end
