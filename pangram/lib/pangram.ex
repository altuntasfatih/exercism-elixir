defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  def pangram?(letters) when is_list(letters) and length(letters) >= 26 do
    count =
      letters
      |> Enum.reduce(0, fn l, acc ->
        if letter?(l), do: acc + 1, else: acc
      end)
    if count == 26, do: true, else: false
  end
  def pangram?(letters) when is_list(letters), do: false

  def pangram?(sentence) do
    sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.uniq()
    |> Enum.sort()
    |> pangram?()
  end
  defp letter?(ch) when ch in ?a..?z, do: true
  defp letter?(_), do: false
end
