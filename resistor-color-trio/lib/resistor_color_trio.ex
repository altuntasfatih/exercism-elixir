defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    [first, second, factor] = Enum.map(colors, &color/1)
    resistance = (first * 10 + second) * :math.pow(10, factor)

    if resistance > 1000, do: {resistance / 1000, :kiloohms}, else: {resistance, :ohms}
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
