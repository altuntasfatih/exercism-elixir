defmodule ResistorColor do
  @moduledoc false

  @resistor_color_value %{
    "black" => 0,
    "brown" => 1,
    "red" => 2,
    "orange" => 3,
    "yellow" => 4,
    "green" => 5,
    "blue" => 6,
    "violet" => 7,
    "grey" => 8,
    "white" => 9
  }
  @spec colors() :: list(String.t())
  def colors do
    Map.to_list(@resistor_color_value)
    |> Enum.sort(fn {_, x1}, {_, x2} -> x1 < x2 end)
    |> Enum.map(fn {color, _} -> color end)
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    Map.get(@resistor_color_value, color)
  end
end
