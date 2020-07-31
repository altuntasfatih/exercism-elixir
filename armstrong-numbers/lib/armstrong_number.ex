defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    solution_one(number) && solution_two(number)
  end

  defp solution_one(number) do
    digits = Integer.digits(number)
    power = length(digits)

    Enum.reduce(digits, 0, fn n, acc ->
      acc + (:math.pow(n, power) |> trunc)
    end)
    |> eq(number)
  end

  defp solution_two(number) do
    power = Integer.digits(number) |> length

    calculate(number, 0, power)
    |> trunc()
    |> eq(number)
  end

  defp calculate(number, acc, power) when number < 10 do
    acc + :math.pow(number, power)
  end

  defp calculate(number, acc, power) do
    acc = acc + (rem(number, 10) |> :math.pow(power))
    calculate(div(number, 10), acc, power)
  end

  defp eq(number, number), do: true
  defp eq(_, _), do: false
end
