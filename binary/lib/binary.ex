defmodule Binary do
  use Bitwise
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.to_charlist
    |> Enum.reduce_while(0, &update_number/2)
  end

  defp update_number(?0, number), do: {:cont, number <<< 1}
  defp update_number(?1, number), do: {:cont, number <<< 1 ||| 1}
  defp update_number(_, _), do: {:halt, 0}
end
