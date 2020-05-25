defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil
  def convert([], _, _), do: nil

  def convert(digits, base_a, base_b) do
    Enum.reverse(digits)
    |> Enum.with_index()
    |> from_base(base_a, 0)
    |> to_base(base_b, [])
  end

  def to_base(nil, _, _), do: nil
  def to_base(value, base, acc) when value < base, do: [value | acc]

  def to_base(value, base, acc) do
    to_base(div(value, base), base, [rem(value, base) | acc])
  end

  defp from_base([{head, index} | tail], base, acc) when head >= 0 and head < base do
    from_base(tail, base, acc + head * :math.pow(base, index))
  end

  defp from_base([], _base, acc), do: trunc(acc)
  defp from_base([_ | _], _, _), do: nil
end
