defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Enum.to_list(2..limit)
    |> sieve(limit, [])
    |> Enum.reverse()
  end

  def sieve([], _, acc), do: acc

  def sieve([n | tail], limit, acc) do
    multiples =
      Stream.iterate(n * n, fn x -> x + n end)
      |> Enum.take_while(&(&1 <= limit))

    sieve(tail -- multiples, limit, [n | acc])
  end
end
