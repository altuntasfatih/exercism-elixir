defmodule CustomSet do
  defstruct map: nil
  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new([]), do: empty_set()

  def new(enumerable) do
    set =
      Enum.reduce(enumerable, %{}, fn i, acc ->
        Map.put(acc, i, nil)
      end)

    %CustomSet{map: set}
  end

  defp empty_set(), do: %CustomSet{}

  @spec empty?(t) :: boolean
  def empty?(%CustomSet{map: nil}), do: true
  def empty?(_), do: false

  @spec contains?(t, any) :: boolean
  def contains?(%CustomSet{map: nil}, _), do: false
  def contains?(custom_set, element) do
    Map.has_key?(custom_set.map, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(%CustomSet{map: set}, %CustomSet{map: set}), do: true
  def subset?(%CustomSet{map: nil}, _), do: true
  def subset?(_, %CustomSet{map: nil}), do: false
  def subset?(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    Map.keys(set_1)
    |> Enum.all?(fn item -> Map.has_key?(set_2, item) end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%CustomSet{map: nil}, %CustomSet{map: nil}), do: true
  def disjoint?(%CustomSet{map: nil}, _), do: true
  def disjoint?(_, %CustomSet{map: nil}), do: true
  def disjoint?(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    Map.keys(set_1)
    |> Enum.all?(fn item -> not Map.has_key?(set_2, item) end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(%CustomSet{map: set}, %CustomSet{map: set}), do: true
  def equal?(_, _), do: false

  @spec add(t, any) :: t
  def add(%CustomSet{map: nil}, element), do: new([element])
  def add(%CustomSet{map: set}, element) do
    %CustomSet{map: Map.put(set, element, nil)}
  end

  @spec intersection(t, t) :: t
  def intersection(set, set), do: set
  def intersection(%CustomSet{map: nil}, _), do: empty_set()
  def intersection(_, %CustomSet{map: nil}), do: empty_set()
  def intersection(set_1, set_2) do
    Map.keys(set_1.map)
    |> Enum.filter(fn item -> Map.has_key?(set_2.map, item) end)
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(%CustomSet{map: nil}, %CustomSet{map: nil}), do: empty_set()
  def difference(custom_set, %CustomSet{map: nil}), do: custom_set
  def difference(%CustomSet{map: nil}, _), do: empty_set()

  def difference(set_1, set_2) do
    Map.keys(set_1.map)
    |> Enum.filter(fn item -> not Map.has_key?(set_2.map, item) end)
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set, %CustomSet{map: nil}), do: custom_set
  def union(%CustomSet{map: nil}, custom_set), do: custom_set
  def union(custom_set_1, custom_set_2) do
    %CustomSet{map: Map.merge(custom_set_1.map, custom_set_2.map)}
  end
end
