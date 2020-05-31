defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    find_factors(number, 2, [])
    |> Enum.reverse()
  end

  def find_factors(1, _, acc), do: acc

  def find_factors(number, factor, acc) when rem(number, factor) == 0 do
    if is_prime?(factor) do
      div(number, factor)
      |> check_itsel(factor, [factor | acc])
    else
      find_factors(number, factor + 1, acc)
    end
  end

  def find_factors(number, factor, acc) do
    find_factors(number, factor + 1, acc)
  end

  def check_itsel(number, factor, acc) do
    if is_prime?(number) do
      [number | acc]
    else
      find_factors(number, factor, acc)
    end
  end

  def is_prime?(2), do: true
  def is_prime?(3), do: true

  def is_prime?(number) when number > 4 do
    limit = :math.sqrt(number) |> trunc
    is_prime?(number, 2, limit)
  end

  def is_prime?(_), do: false

  def is_prime?(number, factor, _) when rem(number, factor) == 0, do: false

  def is_prime?(number, factor, limit) when factor < limit do
    is_prime?(number, factor + 1, limit)
  end
  def is_prime?(_, _, _), do: true
end
