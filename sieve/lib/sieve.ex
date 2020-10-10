defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Enum.to_list(2..limit)
    |> iterate([], :math.sqrt(limit) |> trunc)
    |> Enum.reverse()
  end

  def iterate([head | tail], acc, limit) when head <= limit do
    filter(tail, head)
    |> iterate([head | acc], limit)
  end

  def iterate(list, acc, _), do: Enum.reverse(list) ++ acc

  def filter(acc, number) do
     Enum.filter(acc, fn x -> rem(x, number) != 0 end)
    #{_, result} = filter(acc, number)
    #Enum.reverse(result)
  end

  def filter(acc, number) do
    Enum.reduce(acc, {1, []}, fn x, {f, a} ->
      if x == number * f do
        {f + 1, a}
      else
        {f, [x | a]}
      end
    end)
  end
end
