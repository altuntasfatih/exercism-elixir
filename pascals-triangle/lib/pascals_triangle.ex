defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  test result of solution_one vs solution two

  solution_one ->
  PascalsTriangleTest
  * test fifth row (4.0ms)
  * test 5000 row (12057.8ms)
  * test one row (0.00ms)
  * test 2000 row (1651.0ms)
  * test twentieth row (0.07ms)
  * test three rows (0.00ms)
  * test two rows (0.00ms)
  * test fourth row (0.01ms)
  Finished in 13.7 seconds
  8 tests, 0 failures

  solution_two ->
  PascalsTriangleTest
  * test one row (1.3ms)
  * test 5000 row (16807.6ms)
  * test fifth row (0.04ms)
  * test fourth row (0.01ms)
  * test twentieth row (0.08ms)
  * test 2000 row (1832.1ms)
  * test three rows (0.01ms)
  * test two rows (0.01ms)
  Finished in 18.7 seconds
  8 tests, 0 failures

  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    solution_one(num)
  end

  def solution_two(num) do
    Stream.iterate([1], fn x ->
      x = [0 | x]

      Enum.chunk_every(x, 2, 1, [0])
      |> Enum.map(&Enum.sum/1)
    end)
    |> Enum.take(num)
  end

  def solution_one(num) do
    Enum.to_list(1..num)
    |> Enum.reduce([], fn r, acc ->
      trinangle(r, acc)
    end)
    |> Enum.reverse()
  end

  def trinangle(1, []), do: [[1]]

  def trinangle(_, [head | _] = acc) do
    sub =
      Enum.chunk_every(head, 2, 1, [0])
      |> Enum.map(&Enum.sum/1)

    [[1 | sub] | acc]
  end
end
