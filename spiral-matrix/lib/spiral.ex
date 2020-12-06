defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.

  (row,column)
  for  (row,column)
      0,0..dimension
      0..dimension,dimension
      dimension,dimension..0
      dimension..0  ,0


      Enum.

  """
  def matrix(dimension) do
    matrix(dimension, 0, [])
  end

  def matrix(0, _, acc), do: acc

  def matrix(1, round, acc) when round != 0 do
    acc ++ [{round, round}]
  end

  def matrix(1, 0, acc) do
    acc ++ [{0, 0}]
  end

  def matrix(dimension, round, acc) do
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
