defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    clear_string = String.downcase(str) |> String.replace(~r/[\s]|[\W]/, "")

    length = String.length(clear_string)
    c = :math.sqrt(length) |> Float.ceil() |> trunc
    r = :math.sqrt(length) |> Float.floor() |> trunc

    folding_part = List.duplicate(" ", c * r - length)

    String.graphemes(clear_string)
    |> Enum.chunk_every(c, c, folding_part)
    |> Enum.flat_map(&Enum.with_index(&1))
    |> Enum.reduce(%{}, fn {v, k}, acc -> Map.update(acc, k, v, fn e -> e <> v end) end)
    |> Enum.map_join(" ", fn {_, v} -> String.trim(v) end)
  end
end
