defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """

  @spec valid?(String.t()) :: boolean
  def valid?(number) when is_binary(number) do
    number = String.replace(number, ~r/\s+/, "")

    cond do
      not Regex.match?(~r/^[0-9]+$/, number) -> false
      String.length(number) < 2 -> false
      true -> checksum(number) |> rem(10) == 0
    end
  end

  def checksum(numbers) do
    String.codepoints(numbers)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {number, index}, acc ->
      if rem(index + 1, 2) == 0 do
        acc + double(number)
      else
        acc + number
      end
    end)
  end

  defp double(number) when number > 4, do: number * 2 - 9
  defp double(number), do: number * 2
end
