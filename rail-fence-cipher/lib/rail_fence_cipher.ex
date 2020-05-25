defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """

  def encode(str, 1), do: str
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    ray_indexs = index(rails, String.length(str)) |> Enum.with_index()

    ray_to_list =
      Enum.to_list(0..(rails - 1))
      |> Enum.reduce(%{}, fn item, acc ->
        Map.put(acc, item, [])
      end)

    Enum.reduce(ray_indexs, ray_to_list, fn {ray_index, i}, acc ->
      ray = Map.get(acc, ray_index)
      item = String.slice(str, i, 1)
      Map.put(acc, ray_index, [item | ray])
    end)
    |> Map.to_list()
    |> Enum.sort(fn {i1, _}, {i2, _} -> i1 < i2 end)
    |> Enum.flat_map(fn {_i, v} ->
      Enum.reverse(v)
    end)
    |> Enum.join()
  end

  @spec index(any, any, [any], number, any) :: [{any, integer}]
  def index(number, limit) do
    index(0, true, [], limit, number - 1)
  end

  def index(_, _, acc, limit, _) when length(acc) == limit do
    acc
    |> Enum.reverse()
  end

  def index(max, true, acc, limit, max), do: index(max - 1, false, [max | acc], limit, max)

  def index(number, true, acc, limit, max),
    do: index(number + 1, true, [number | acc], limit, max)

  def index(0, false, acc, limit, max), do: index(1, true, [0 | acc], limit, max)

  def index(number, false, acc, limit, max),
    do: index(number - 1, false, [number | acc], limit, max)

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  def decode(str, 1) do
    str
  end
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    ray_indexs = index(rails, String.length(str))

    {ray_to_list, _} =
      Enum.reduce(ray_indexs, %{}, fn i, acc ->
        Map.update(acc, i, 1, fn x -> x + 1 end)
      end)
      |> Enum.reduce({%{}, 0}, fn {k, length}, {acc, index} ->
        {Map.put(acc, k, String.slice(str, index, length)), index + length}
      end)

    {_, result} =
      Enum.reduce(ray_indexs, {ray_to_list, ""}, fn i, {list, acc} ->
        <<first::bytes-size(1), rest::binary>> = Map.get(list, i)

        {Map.put(list, i, rest), acc <> first}
      end)

    result
  end
end
