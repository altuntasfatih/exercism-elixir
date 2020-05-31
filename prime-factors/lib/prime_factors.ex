defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.
  The prime factors are prime numbers that when multiplied give the desired
  number.
  The prime factors of 'number' will be ordered lowest to highest.

  Test results ->
    PrimeFactorsTest
      * test 4 (0.00ms)
      * test 93819012551 (0.3ms)
      * test 1 (0.00ms)
      * test 2 (0.00ms)
      * test 8 (0.00ms)
      * test 10000000055 (0.6ms)
      * test 901255 (0.00ms)
      * test 625 (0.00ms)
      * test 3 (0.00ms)
      * test 9 (0.00ms)
      * test 6 (0.00ms)
      * test 27 (0.00ms)

    Finished in 0.03 seconds
    12 tests, 0 failures
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, 2, [])
    |> Enum.reverse()
  end

  def factors_for(1, _, acc), do: acc

  def factors_for(number, factor, acc) when rem(number, factor) == 0 do
    number = div(number, factor)
    acc = [factor | acc]

    if is_prime?(number) do
      [number | acc]
    else
      factors_for(number, factor, acc)
    end
  end

  def factors_for(number, factor, acc), do: factors_for(number, factor + 1, acc)

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
