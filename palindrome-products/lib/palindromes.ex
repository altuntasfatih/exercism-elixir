defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """

  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    Enum.to_list(min_factor..max_factor)
    |> split()
  end

  def split(list) when length(list) > 100 do
    Enum.chunk_every(list, trunc(length(list) / 10))
    |> Enum.map(fn sublist ->
      Task.async(fn ->
        generate_palindrome(sublist, %{})
      end)
    end)
    |> Enum.map(fn task -> Task.await(task) end)
    |> Enum.reduce(%{}, fn sub, acc ->
      Map.merge(acc, sub)
    end)
  end

  def split(list) do
    generate_palindrome(list, %{})
  end

  defp generate_palindrome([], acc), do: acc

  defp generate_palindrome(list = [head | tail], acc) do
    acc =
      Enum.reduce(list, acc, fn i, acc ->
        product = head * i
        pair = [head, i]

        if palindrome?(product) do
          Map.update(acc, product, [pair], fn old ->
            [pair | old]
          end)
        else
          acc
        end
      end)

    generate_palindrome(tail, acc)
  end

  def palindrome?(number) do
    number = Integer.to_string(number)
    palindrome?(number, String.reverse(number))
  end

  def palindrome?(number, number), do: true
  def palindrome?(_, _), do: false
end
