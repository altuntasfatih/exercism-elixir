defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Enum.to_list([3, 5, 7])
    |> Enum.reduce("", fn divider, acc ->
      case rem(number, divider) do
        0 -> label(acc, divider)
        _ -> acc
      end
    end)
    |> print(number)
  end

  defp label(label, divider) when divider == 3, do: label <> "Pling"
  defp label(label, divider) when divider == 5, do: label <> "Plang"
  defp label(label, divider) when divider == 7, do: label <> "Plong"

  defp print("", number) do
    to_string(number)
  end

  defp print(label, _) do
    label
  end
end
