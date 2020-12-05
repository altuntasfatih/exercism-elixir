defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) when is_binary(plaintext) do
    plaintext
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(fn c -> (c >= ?a and c <= ?z) or (c >= ?0 and c <= ?9) end)
    |> Enum.map(&encode/1)
    |> Enum.chunk_every(5)
    |> Enum.map(fn x -> List.to_string(x) end)
    |> Enum.join(" ")
  end

  def encode(c) when c >= ?a and c <= ?z do
    ?z - (c - ?a)
  end

  def encode(c), do: c

  @spec decode(String.t()) :: String.t()
  def decode(cipher) when is_binary(cipher) do
    cipher
    |> String.to_charlist()
    |> Enum.filter(fn c -> (c >= ?a and c <= ?z) or (c >= ?0 and c <= ?9) end)
    |> Enum.map(&decode/1)
    |> List.to_string()
  end

  def decode(c) when c >= ?a and c <= ?z do
    ?a + (?z - c)
  end

  def decode(c), do: c
end
