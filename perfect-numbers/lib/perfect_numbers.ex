defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  def classify(1), do: {:ok, :deficient}

  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) do
    limit = div(number, 2)

    aliquot_sum(limit, 0, number)
    |> class(number)
  end

  defp class(sum, sum), do: {:ok, :perfect}
  defp class(sum, number) when sum > number, do: {:ok, :abundant}
  defp class(_, _), do: {:ok, :deficient}

  defp aliquot_sum(0, acc, _), do: acc

  defp aliquot_sum(factor, acc, number) when rem(number, factor) == 0 do
    aliquot_sum(factor - 1, acc + factor, number)
  end

  defp aliquot_sum(factor, acc, number) do
    aliquot_sum(factor - 1, acc, number)
  end
end
