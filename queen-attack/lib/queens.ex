defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  def new([{_, value}, {_, value}]), do: raise(ArgumentError)

  def new([{:white, _} = white, {:black, _} = black]) do
    %Queens{
      white: new(white).white,
      black: new(black).black
    }
  end

  @spec new(Keyword.t()) :: Queens.t()
  def new([head | _]), do: new(head)

  def new({key, {x, y}})
      when x >= 0 and y >= 0 and x < 8 and y < 8 and key in [:white, :black] do
    create(key, {x, y})
  end

  def new(_), do: raise(ArgumentError)

  defp create(key, value) do
    %Queens{} |> Map.put(key, value)
  end

  defp row() do
    Enum.to_list(0..7)
    |> Enum.reduce(%{}, fn i, acc ->
      Map.put(acc, i, "_")
    end)
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    Enum.to_list(0..7)
    |> Enum.reduce(%{}, fn i, acc ->
      Map.put(acc, i, row())
    end)
    |> put(queens.black, "B")
    |> put(queens.white, "W")
    |> Map.values()
    |> Enum.map(&Map.values/1)
    |> Enum.reduce("", fn row, acc ->
      acc <> Enum.join(row, " ") <> "\n"
    end)
    |> String.slice(0..-2)
  end

  defp put(board, nil, _), do: board

  defp put(board, {x1, y1}, stone) do
    put_in(board, [x1, y1], stone)
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    can_atack?(queens.black, queens.white)
  end

  defp can_atack?({x, _}, {x, _}), do: true
  defp can_atack?({_, y}, {_, y}), do: true
  defp can_atack?({x1, y1}, {x2, y2}) when abs(x1 - x2) == abs(y1 - y2), do: true
  defp can_atack?(_, _), do: false
end
