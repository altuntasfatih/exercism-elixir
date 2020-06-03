defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    flat(list, []) |> Enum.reverse()
  end

  defp concat(nil, acc), do: acc
  defp concat([], acc), do: acc

  defp concat([_head | _tail] = list, acc) do
    flat(list, acc)
  end

  defp concat(item, acc), do: [item | acc]

  def flat([head | tail] = _list, acc) do
    acc = concat(head, acc)
    flat(tail, acc)
  end

  def flat([], acc) do
    acc
  end
end
