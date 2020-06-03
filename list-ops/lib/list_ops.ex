defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn _, acc ->
      acc + 1
    end)
  end

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([head | tail], n), do: reverse(tail, [head | n])
  def reverse([], n), do: n

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: map(l, f, [])
  def map([head | tail], f, result), do: map(tail, f, [f.(head) | result])
  def map([], _, result), do: reverse(result)

  def filter(l, f) do
    reduce(l, [], fn item, acc ->
      if f.(item), do: [item | acc], else: acc
    end)
    |> reverse()
  end

  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)
  def reduce([], acc, _f), do: acc

  def append(a, b) do
    reverse(a)
    |> reduce(b, fn item, acc ->
      [item | acc]
    end)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    concat(ll, [])
    |> reverse()
  end

  def concat([head | tail], r) when is_list(head), do: concat(tail, concat(head, r))
  def concat([head | tail], r), do: concat(tail, [head | r])
  def concat([], r), do: r
end
