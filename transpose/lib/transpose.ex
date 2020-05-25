defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    lines = String.split(input, "\n")

    max_length = Enum.map(lines, &String.length/1) |> Enum.max()

    Enum.map(lines, fn x ->
      String.pad_trailing(x, max_length)
      |> String.codepoints()
    end)
    |> Enum.zip()
    |> Enum.map_join("\n",fn x->
      Tuple.to_list(x)|> Enum.join
    end)
    |> String.trim_trailing()


  end

  """

  def test_data() do
    str = "ABC first line.\n" <> "XYZ second line."
    str |>  String.split("\n") |> Enum.map(fn x -> String.codepoints(x) end)
  end

  def zip(list) do
    zip(list, [])
  end

  def zip([], acc) do
    acc
    |> Enum.reverse()
  end

  def zip(list, acc) do
    [zip_data, rest] = Enum.reduce(list, [{}, []], &zip_item/2)

    zip(rest, [zip_data | acc])
  end

  def zip_item([head | inner_tail], [acc, rest]) do
    [Tuple.append(acc, head), [inner_tail | rest]]
  end

  def zip_item([], [acc, rest]) do
    [Tuple.append(acc, "?"), rest]
  end
  """
end
