defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    pure_string =
      sentence
      |> String.downcase()
      |> String.replace(~r/[-\s]/, "")

    String.length(pure_string) ==
      pure_string |> String.codepoints() |> Enum.uniq() |> Enum.count()
  end
end
