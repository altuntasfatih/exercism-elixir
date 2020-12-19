defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.

  """
  def matrix(0), do: []

  def matrix(dimension) do
    matrix(dimension, 0, [])
    |> convert(dimension)
  end

  def spiral_iterate(dimension) do
    matrix(dimension, 0, [])
  end

  defp convert(matrix, dimension) do
    Enum.with_index(matrix)
    |> Enum.map(fn {loc, index} -> {loc, index + 1} end)
    |> Enum.sort(fn {{r, c}, _}, {{r2, c2}, _} ->
      if r == r2 do
        c < c2
      else
        r < r2
      end
    end)
    |> Enum.map(fn {_, value} -> value end)
    |> Enum.chunk_every(dimension)
  end

  defp matrix(0, _, acc), do: acc
  defp matrix(1, round, acc) when round != 0, do: acc ++ [{round, round}]
  defp matrix(1, 0, acc), do: acc ++ [{0, 0}]

  defp matrix(dimension, round, acc) do
    index = dimension - 1
    start = 0
    part_one = start..index |> Enum.to_list() |> Enum.map(fn c -> {round, c + round} end)

    part_two = start..index |> Enum.to_list() |> Enum.map(fn c -> {c + round, index + round} end)
    part_three =
      index..start |> Enum.to_list() |> Enum.map(fn c -> {index + round, c + round} end)

    part_four = index..(start + 1) |> Enum.to_list() |> Enum.map(fn c -> {c + round, round} end)

    acc = acc ++ part_one ++ tl(part_two) ++ tl(part_three) ++ tl(part_four)

    matrix(dimension - 2, round + 1, acc)
  end
end
