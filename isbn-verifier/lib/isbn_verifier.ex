defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """

  def isbn?(isbn) when is_bitstring(isbn) do
    isbn
    |> String.replace(~r/[^\w]/, "")
    |> String.graphemes()
    |> isbn?()
  end

  def isbn?(isbn) when is_list(isbn) and length(isbn) == 10 do
    isbn
    |> Enum.reverse()
    |> Enum.with_index()
    |> isbn?(0)
  end

  def isbn?(_), do: false

  defp isbn?([{"X", _} | tail], acc) do
    isbn?(tail, acc + 10 * 1)
  end

  defp isbn?([{number, index} | tail], acc) do
    case Integer.parse(number, 10) do
      {number, _} ->
        isbn?(tail, acc + number * (index + 1))

      :error ->
        false
    end
  end

  defp isbn?([], acc) when rem(acc, 11) == 0, do: true
  defp isbn?(_, _), do: false
end
