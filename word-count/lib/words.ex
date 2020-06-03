defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  ## /u unicode support for last case

  @spec count(String.t()) :: map
  def count(sentence) do
    String.downcase(sentence)
    |> String.split(~r/[^[:alnum:]\-]/u, trim: true)
    |> Enum.reduce(%{}, fn item, map ->
      Map.update(map, item, 1, fn value -> value + 1 end)
    end)
  end
end
