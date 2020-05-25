defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when length(a) == length(b) do
    if equals?(a, b), do: :equal, else: :unequal
  end

  def compare(a, b) when length(a) < length(b) do
    if sublist?(a, a, b), do: :sublist, else: :unequal
  end

  def compare(a, b) when length(a) > length(b) do
    if sublist?(b, b, a), do: :superlist, else: :unequal
  end

  defp sublist?(sublist, [head | tail], [head | list]) do
    if contains?(tail, list), do: true, else: sublist?(sublist, sublist, list)
  end

  defp sublist?(sublist, _, [_ | list]) when length(sublist) > length(list), do: false
  defp sublist?(sublist, [_ | _], [_ | list]), do: sublist?(sublist, sublist, list)
  defp sublist?(_, [], _), do: true
  defp sublist?(_, _, []), do: false

  defp contains?([head | tail], [head | tail2]), do: contains?(tail, tail2)
  defp contains?([], _), do: true
  defp contains?([_ | _], []), do: false
  defp contains?([_ | _], [_ | _]), do: false

  defp equals?(a, a), do: true
  defp equals?(_, _), do: false
end
