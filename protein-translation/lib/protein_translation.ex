defmodule ProteinTranslation do
  @codon_to_protein %{
    "UGU" => :Cysteine,
    "UGC" => :Cysteine,
    "UUA" => :Leucine,
    "UUG" => :Leucine,
    "AUG" => :Methionine,
    "UUU" => :Phenylalanine,
    "UUC" => :Phenylalanine,
    "UCU" => :Serine,
    "UCC" => :Serine,
    "UCA" => :Serine,
    "UCG" => :Serine,
    "UGG" => :Tryptophan,
    "UAU" => :Tyrosine,
    "UAC" => :Tyrosine,
    "UAA" => :STOP,
    "UAG" => :STOP,
    "UGA" => :STOP
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    String.codepoints(rna)
    |> Enum.chunk_every(3)
    |> Enum.map(fn item ->
      Map.get(@codon_to_protein, Enum.join(item))
    end)
    |> convert([])
  end

  defp convert([], acc), do: {:ok, Enum.reverse(acc)}
  defp convert([:STOP | _], acc), do: {:ok, Enum.reverse(acc)}
  defp convert([nil | _], _), do: {:error, "invalid RNA"}
  defp convert([value | tail], acc), do: convert(tail, [to_string(value) | acc])

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.get(@codon_to_protein, codon) do
      nil -> {:error, "invalid codon"}
      value -> {:ok, to_string(value)}
    end
  end
end
