defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map(fn word ->
      wowel?(word)
      |> translate(word)
    end)
    |> Enum.join(" ")
  end

  defp translate(true, phrase) do
    phrase <> "ay"
  end

  defp translate(false, phrase) do
    split_consonants(phrase, []) <> "ay"
  end

  defp split_consonants(phrase, acc) do
    if wowel?(phrase) do
      phrase <> Enum.join(Enum.reverse(acc))
    else
      {head, tail} = split_consonants(phrase)
      split_consonants(tail, [head | acc])
    end
  end

  defp wowel?("a" <> _), do: true
  defp wowel?("e" <> _), do: true
  defp wowel?("i" <> _), do: true
  defp wowel?("o" <> _), do: true
  defp wowel?("u" <> _), do: true
  defp wowel?("x" <> rest), do: true and not wowel?(rest)
  defp wowel?("y" <> rest), do: true and not wowel?(rest)
  defp wowel?(_), do: false

  defp split_consonants("ch" <> rest), do: {"ch", rest}
  defp split_consonants("qu" <> rest), do: {"qu", rest}
  defp split_consonants("squ" <> rest), do: {"squ", rest}
  defp split_consonants("th" <> rest), do: {"th", rest}
  defp split_consonants("thr" <> rest), do: {"thr", rest}
  defp split_consonants("sch" <> rest), do: {"sch", rest}

  defp split_consonants(phrase) do
    head = String.slice(phrase, 0..0)
    tail = String.slice(phrase, 1..-1)
    {head, tail}
  end
end
