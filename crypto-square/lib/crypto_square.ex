defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str
    |> String.downcase()
    |> String.replace(~r[\s*], "")
    |> String.replace(~r[^\w\s], "")
    |> transform_rectangle()
  end

  def transform_rectangle(str) do
    length = String.length(str)
    c = :math.sqrt(length) |> Float.ceil() |> trunc
    r = :math.sqrt(length) |> Float.floor() |> trunc

    Enum.to_list(1..r)
    |> Enum.reduce(%{}, fn x, acc ->
      Map.put(acc, x, create_map(c))
    end)
  end

  defp create_map(size) do
    Enum.to_list(0..(size - 1))
    |> Enum.reduce(%{}, fn x, acc ->
      Map.put(acc, x, nil)
    end)
  end

  def get_column(index, size, str) do
    String.codepoints(str)
    |> Enum.with_index()
    |> Enum.filter(fn {_, i} ->
      cond do
        i == index -> true
        rem(i - index, size) == 0 -> true
        true -> false
      end
    end)
    |> Enum.map(fn {s, _} -> s end)
  end
end
