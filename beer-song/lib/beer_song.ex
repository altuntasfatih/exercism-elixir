defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    lyrics(number..number)
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  def lyrics(range \\ 99..0) do
    Enum.to_list(range) |> print_lyrics("")
  end
  defp modify_space(result, []), do: result
  defp modify_space(result, _tail), do: result <> "\n"
  defp print_lyrics([0 | tail], result) do
    result =
      result <>
        """
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
        """

    print_lyrics(tail, result)
  end
  defp print_lyrics([1 | tail], result)  do
    result =
      result <>
        """
        1 bottle of beer on the wall, 1 bottle of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
        """

    print_lyrics(tail, modify_space(result, tail))
  end
  defp print_lyrics([2 | tail], result)do
    result =
      result <>
        """
        2 bottles of beer on the wall, 2 bottles of beer.
        Take one down and pass it around, 1 bottle of beer on the wall.
        """

    print_lyrics(tail, modify_space(result, tail))
  end
  defp print_lyrics([head | tail], result) do
    result =
      result <>
        """
        #{head} bottles of beer on the wall, #{head} bottles of beer.
        Take one down and pass it around, #{head - 1} bottles of beer on the wall.
        """

    print_lyrics(tail, modify_space(result, tail))
  end
  defp print_lyrics([], result) do
    result
  end
end
