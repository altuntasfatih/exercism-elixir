defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """


  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase
    |> String.graphemes
    |> Enum.map(&score_letter/1)
    |> Enum.sum
  end

  for {letters, score} <- [
    {"aeioulnrst", 1},
    {"dg", 2},
    {"bcmp", 3},
    {"fhvwy", 4},
    {"k", 5},
    {"jx", 8},
    {"qz", 10}
  ] do
    for letter <- letters |> String.graphemes do
      defp score_letter(unquote(letter)), do: unquote(score)
    end
  end
  defp score_letter(_), do: 0
end
