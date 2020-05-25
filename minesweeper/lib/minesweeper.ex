defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """

  def annotate([]), do: []
  @spec annotate([String.t()]) :: [String.t()]
  def annotate(board = [head | _tail]) do
    row_size = length(board)
    column_size = String.length(head)

    create_map(board)
    |> spot_mines(row_size, column_size)
    |> Map.values()
    |> Enum.map(fn x -> Map.values(x) |> Enum.join() end)
  end

  defp create_map(board) do
    Enum.with_index(board)
    |> Enum.reduce(%{}, fn {value, key}, acc ->
      row = for {val, key} <- Enum.with_index(String.codepoints(value)), into: %{}, do: {key, val}
      Map.put(acc, key, row)
    end)
  end

  defp spot_mines(map, row_size, column_size) do
    index_list =
      for r <- Enum.to_list(0..(row_size - 1)),
          c <- Enum.to_list(0..(column_size - 1)),
          do: [r, c]

    Enum.reduce(index_list, map, fn [r, c], acc ->
      update_board(acc[r][c], [r, c], acc)
    end)
  end

  defp update_board("*", [r, c], acc) do
    update_neighboor(acc, [r - 1, c - 1])
    |> update_neighboor([r - 1, c])
    |> update_neighboor([r - 1, c + 1])
    |> update_neighboor([r, c - 1])
    |> update_neighboor([r, c + 1])
    |> update_neighboor([r + 1, c - 1])
    |> update_neighboor([r + 1, c])
    |> update_neighboor([r + 1, c + 1])
  end

  defp update_board(_, _, acc), do: acc

  defp update_neighboor(acc, [r, c]) when r >= 0 or c >= 0 do
    case acc[r][c] do
      nil -> acc
      "*" -> acc
      " " -> Kernel.put_in(acc, [r, c], 1)
      number -> Kernel.put_in(acc, [r, c], number + 1)
    end
  end

  defp update_neighboor(acc, _), do: acc
end
