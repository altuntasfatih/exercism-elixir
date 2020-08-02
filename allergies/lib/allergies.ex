defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]

  def list(0), do: []
  def list(1), do: ~w[eggs]

  def list(flag) when rem(flag, 2) == 1 do
    list(1) ++ list(flag - 1)
  end

  def list(flag) when flag >= 128 do
    ~w[cats] ++ list(flag - 128)
  end

  def list(flag) when flag >= 64 do
    ~w[pollen] ++ list(flag - 64)
  end

  def list(flag) when flag >= 32 do
    ~w[chocolate] ++ list(flag - 32)
  end

  def list(flag) when flag >= 16 do
    ~w[tomatoes] ++ list(flag - 16)
  end

  def list(flag) when flag >= 8 do
    ~w[strawberries] ++ list(flag - 8)
  end

  def list(flag) when flag >= 4 do
    ~w[shellfish] ++ list(flag - 4)
  end

  def list(flag) when flag >= 2 do
    ~w[peanuts] ++ list(flag - 2)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
