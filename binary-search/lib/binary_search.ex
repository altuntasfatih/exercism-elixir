defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    binary_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp binary_search(_list, _key, lower, upper) when lower > upper or upper < lower do
    :not_found
  end

  defp binary_search(list, key, lower, upper) do
    middle = lower + floor((upper - lower) / 2)
    item = elem(list, middle)
    cond do
      key == item -> {:ok, middle}
      key < item -> binary_search(list, key, lower, middle - 1)
      key > item -> binary_search(list, key, middle + 1, upper)
    end
  end
end
