defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(values,amount ) do
    gen(amount, Enum.sort(values, &>/2), %{})
  end

  defp gen(0, _, map), do: {:ok, map}
  defp gen(_, [], map), do: :error

  defp gen(amount, [hd | tail], map) do
    map = put_in(map[hd], div(amount, hd))
    gen(rem(amount, hd), tail, map)
  end
end
