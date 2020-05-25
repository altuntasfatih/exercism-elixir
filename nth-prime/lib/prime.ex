defmodule Prime do
  @doc """
  Generates the nth prime.
  """

  @max_limit 100_000_000_000
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    nth(count, 2)

    #nth_with_sieve(count)
    #|> Enum.at(count - 1)
  end

  def find_limit(number) when number > 100_000, do: @max_limit
  def find_limit(number), do: number * number

  def nth_with_sieve(count) do
    limit = find_limit(count)

    Enum.to_list(2..limit)
    |> nth_with_sieve(2, limit)
  end

  def nth_with_sieve(list, p, limit) when p * p > limit, do: list

  def nth_with_sieve(list, prime, limit) do
    filtered_list = Enum.filter(list, fn x -> x == prime or rem(x, prime) != 0 end)
    next_prime = Enum.find(filtered_list, fn x -> x > prime end)
    nth_with_sieve(filtered_list, next_prime, limit)
  end

  def nth(0, prime_number) do
    prime_number - 1
  end

  def nth(count, number) do
    if prime?(number) do
      nth(count - 1, number + 1)
    else
      nth(count, number + 1)
    end
  end

  defp prime?(number), do: prime?(number, 2)
  defp prime?(number, acc) when acc * acc > number, do: true
  defp prime?(number, acc) when rem(number, acc) == 0, do: false
  defp prime?(number, acc), do: prime?(number, acc + 1)
end
