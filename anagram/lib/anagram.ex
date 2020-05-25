defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, fn candidate ->
      String.downcase(base)
      |> anagram?(String.downcase(candidate))
    end)
  end
  defp anagram?(word, word), do: false
  defp anagram?(word, word2) do
    word =
      String.codepoints(word)
      |> Enum.sort()

    word2 =
      String.codepoints(word2)
      |> Enum.sort()

    word == word2
  end
end
