defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Map.to_list(input)
    |> Enum.reduce(%{}, fn {value, key_list}, acc ->
      Enum.reduce(key_list, acc, fn key, ac ->
        Map.put(ac, String.downcase(key), value)
      end)
    end)
  end
end
