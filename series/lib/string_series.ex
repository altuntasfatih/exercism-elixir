defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    String.graphemes(s)
    |> split_series(size, [])
    |> Enum.reverse()
  end

  def split_series(_list, size, _series) when size == -1 do
    []
  end

  def split_series([_head | tail] = list, size, series) when length(list) >= size do
    case Enum.take(list, size) do
      [] ->
        series
      slice ->
        series = [slice |> Enum.reduce("", fn item, acc -> acc <> item end) | series]
        split_series(tail, size, series)
    end
  end

  def split_series(list, size, series) when length(list) < size do
    series
  end

end
