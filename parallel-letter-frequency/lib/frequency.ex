defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  def frequency([], _), do: []

  def frequency(texts, workers) when length(texts) < workers do
    Enum.map(texts, fn text ->
      Task.async(fn -> count_freq(text) end)
    end)
    |> wait_workers()
  end

  def frequency(texts, workers) do
    part = div(length(texts), workers) + 1

    Enum.map(1..workers, fn x ->
      Enum.slice(texts, (x - 1) * part, part)
    end)
    |> Enum.map(fn text ->
      Task.async(fn ->
        Enum.join(text)
        |> count_freq()
      end)
    end)
    |> wait_workers()
  end

  defp wait_workers(workers) do
    workers
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(%{}, fn acc, r ->
      Map.merge(acc, r, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)
    |> Map.to_list()
  end

  defp count_freq(text) do
    text
    |> String.downcase()
    |> String.codepoints()
    |> Enum.reduce(%{}, fn item, acc ->
      if Regex.match?(~r/\p{L}/u, item) do
        Map.update(acc, item, 1, &(&1 + 1))
      else
        acc
      end
    end)
  end
end
