defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """

  defguard is_positive_integer(value) when is_integer(value) and value > 0

  def calc(1, step), do: step

  def calc(input, step) when is_positive_integer(input) and rem(input, 2) == 0,
    do: calc(trunc(input / 2), step + 1)

  def calc(input, step) when is_positive_integer(input), do: calc(input * 3 + 1, step + 1)

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
    calc(input, 0)
  end
end
