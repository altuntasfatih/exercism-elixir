defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(0), do: ?\s
  def decode_nucleotide(1), do: ?A
  def decode_nucleotide(2), do: ?C
  def decode_nucleotide(4), do: ?G
  def decode_nucleotide(8), do: ?T

  def encode(dna), do: encode(dna, <<>>)

  defp encode([h | t], acc) do
    encode(t, <<acc::bitstring, (<<encode_nucleotide(h)::4>>)>>)
  end

  defp encode([], acc), do: acc

  def decode(dna), do: decode(dna, '')

  defp decode(<<n::4, rest::bitstring>>, acc) do
    decode(rest, acc ++ [decode_nucleotide(n)])
  end

  defp decode(<<>>, acc), do: acc
end
