defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  def convert(?a), do: 10
  def convert(?b), do: 11
  def convert(?c), do: 12
  def convert(?d), do: 13
  def convert(?e), do: 14
  def convert(?f), do: 15
  def convert(n) when n >= 48 and n < 58, do: n - 48
  def convert(_), do: nil

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    String.downcase(hex)
    |> to_charlist()
    |> Enum.reverse()
    |> Enum.with_index()
    |> calculate(0)
    |> trunc()
  end

  def calculate([], acc), do: acc

  def calculate([{c, index} | tail], acc) do
    case convert(c) do
      nil -> 0
      number -> calculate(tail, acc + number * :math.pow(16, index))
    end
  end
end
