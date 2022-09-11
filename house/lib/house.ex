defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @verses [
    "the house that Jack built.",
    "the malt that lay in",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to"
  ]

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(stop, stop) do
    verse(stop)
  end

  def recite(start, stop) do
    Enum.to_list(start..stop)
    |> Enum.map_join("", &verse(&1))
  end

  defp verse(verse_number) do
    verse_number = verse_number - 1

    pharase =
      Enum.with_index(@verses)
      |> Enum.filter(fn {_, index} -> index in 0..verse_number end)
      |> Enum.reverse()
      |> Enum.map(fn {p, _} -> p end)
      |> Enum.join(" ")

    "This is #{pharase}\n"
  end
end
