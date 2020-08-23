defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]

  def list(flag) when flag >= 128, do: ~w[cats] ++ list(flag - 128)
  def list(flag) when flag >= 64, do: ~w[pollen] ++ list(flag - 64)
  def list(flag) when flag >= 32, do: ~w[chocolate] ++ list(flag - 32)
  def list(flag) when flag >= 16, do: ~w[tomatoes] ++ list(flag - 16)
  def list(flag) when flag >= 8, do: ~w[strawberries] ++ list(flag - 8)
  def list(flag) when flag >= 4, do: ~w[shellfish] ++ list(flag - 4)
  def list(flag) when flag >= 2, do: ~w[peanuts] ++ list(flag - 2)
  def list(1), do: ~w[eggs]
  def list(_), do: []

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
