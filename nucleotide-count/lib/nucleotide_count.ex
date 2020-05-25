defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]
  @empty_histogram %{?A => 0, ?T => 0, ?C => 0, ?G => 0}

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    histogram(strand)[nucleotide]
  end
  def count(_, _), do: 0

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Enum.reduce(strand, @empty_histogram, fn n, acc ->
      Map.update(acc, n, 1, &(&1 + 1))
    end)
  end
end
