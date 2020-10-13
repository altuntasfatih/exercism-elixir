defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  def largest_product(number, size) when size > 0 and number != "" do
    preprocess(number)
    |> split(size)
    |> calculate_product_sum
    |> Enum.max()
  end

  def largest_product(_, 0), do: 1
  def largest_product(_, _), do: raise(ArgumentError)

  defp preprocess(number) do
    number
    |> String.graphemes()
    |> Enum.map(fn x ->
      {intVal, _} = Integer.parse(x)
      intVal
    end)
  end

  defp split(list, size) when length(list) >= size do
    Enum.chunk_every(list, size, 1, :discard)
    |> Enum.filter(fn x -> not (0 in x) end)
  end

  defp split(_, _), do: raise(ArgumentError)

  defp calculate_product_sum([]), do: [0]

  defp calculate_product_sum(sublist) do
    Enum.map(sublist, fn serie ->
      Enum.reduce(serie, 1, fn x, acc ->
        acc * x
      end)
    end)
  end
end
