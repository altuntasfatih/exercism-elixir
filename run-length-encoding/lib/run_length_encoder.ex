defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> encode(nil, [])
  end

  def encode([], acc) do
    acc
    |> Enum.reverse()
    |> Enum.join()
  end

  def encode([head | tail], nil, acc) do
    encode(tail, head, acc)
  end

  def encode([head | tail], head, acc) do
    encode(tail, head, acc, 2)
  end

  def encode([head | tail], last, acc) do
    encode(tail, head, [last | acc])
  end

  def encode([], last, acc) do
    encode([], [last | acc])
  end

  def encode([head | tail], head, acc, count) do
    encode(tail, head, acc, count + 1)
  end

  def encode([head | tail], last, acc, count) do
    encode(tail, head, ["#{count}#{last}" | acc])
  end

  def encode([], last, acc, count) do
    encode([], ["#{count}#{last}" | acc])
  end

  def decode(string) do
    string
    |> String.graphemes()
    |> decode([])
  end

  def decode([], acc) do
    acc
    |> Enum.reverse()
    |> Enum.join()
  end

  def decode([ch | tail], acc) do
    case Integer.parse(ch) do
      :error -> decode(tail, [ch | acc])
      {number, ""} -> decode(tail, acc, number)
    end
  end

  def decode([_ | tail], acc, 0) do
    decode(tail, acc)
  end

  def decode([ch | tail], acc, count) do
    case Integer.parse(ch) do
      :error -> decode([ch | tail], [ch | acc], count - 1)
      {number, ""} -> decode(tail, acc, count * 10 + number)
    end
  end
end
