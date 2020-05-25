defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """

  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}

  def hamming_distance(strand1, strand2) when length(strand2) == length(strand1) do
    Enum.zip(strand1, strand2)
    |> Enum.count(fn {x1, x2} -> x1 != x2 end)
    |> ok()
  end

  def hamming_distance(_, _) do
    {:error, "Lists must be the same length"}
  end

  defp ok(count) do
    {:ok, count}
  end
end
