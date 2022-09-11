defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first_color, second_color | _]) do
    color(first_color) * 10 + color(second_color)
  end

  defp color(:black), do: 0
  defp color(:brown), do: 1
  defp color(:red), do: 2
  defp color(:orange), do: 3
  defp color(:yellow), do: 4
  defp color(:green), do: 5
  defp color(:blue), do: 6
  defp color(:violet), do: 7
  defp color(:grey), do: 8
  defp color(:white), do: 9
end
