defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino] | []) :: boolean
  def chain?([]), do: true
  def chain?([{x, x}]), do: true
  def chain?([_]), do: false

  def chain?(dominoes) do
    adjacency_map =
      Enum.reduce(dominoes, %{}, fn {x, y}, acc ->
        Map.update(acc, x, [y], fn list -> list ++ [y] end)
        |> Map.update(y, [x], fn list -> list ++ [x] end)
      end)

    sort = adjacency_map |> Map.keys() |> Enum.sort()
    is_chain?(sort, hd(sort), adjacency_map)
  end

  def is_chain?([head | []], finish, map) do
    case Map.get(map, head) do
      nil ->
        false

      list ->
        finish in list
    end
  end

  def is_chain?([head | [neighboor | tail]], finish, map) do
    case Map.get(map, head) do
      nil ->
        false

      list ->
        if neighboor in list do
          is_chain?([neighboor | tail], finish, map)
        else
          false
        end
    end
  end

  def test() do
    [
      {1, 2},
      {5, 3},
      {3, 1},
      {1, 2},
      {2, 4},
      {1, 6},
      {2, 3},
      {3, 4},
      {5, 6}
    ]
    |> Enum.reduce(%{}, fn {x, y}, acc ->
      Map.update(acc, x, [y], fn list -> list ++ [y] end)
      |> Map.update(y, [x], fn list -> list ++ [x] end)
    end)
  end
end
