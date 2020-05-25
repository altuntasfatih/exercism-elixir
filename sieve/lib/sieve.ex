defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Enum.to_list(2..limit)
    |> iterate([])
    |> Enum.reverse()
  end

  def iterate([], acc), do: acc

  def iterate([head | tail], acc) do
    Enum.filter(tail, fn x -> rem(x, head) != 0 end)
    |> iterate([head | acc])
  end
end
