defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down), do: recite(start_bottle, take_down, "")

  defp recite(bottle_number, 1, acc), do: acc <> from_verse(bottle_number)

  defp recite(bottle_number, take_down, acc) do
    recite(bottle_number - 1, take_down - 1, acc <> from_verse(bottle_number) <> "\n\n")
  end

  defp from_verse(bottle_number) do
    """
    #{line_one_and_two(bottle_number)}
    #{line_one_and_two(bottle_number)}
    And if one green bottle should accidentally fall,
    #{line_four(bottle_number - 1)}\
    """
  end

  defp line_one_and_two(1),
    do: "One green bottle hanging on the wall,"

  defp line_one_and_two(bottle_number),
    do: "#{number_to_text(bottle_number)} green bottles hanging on the wall,"

  defp line_four(1), do: "There'll be one green bottle hanging on the wall."
  defp line_four(0), do: "There'll be no green bottles hanging on the wall."

  defp line_four(bottle_number),
    do:
      "There'll be #{number_to_text(bottle_number) |> String.downcase()} green bottles hanging on the wall."

  defp number_to_text(10), do: "Ten"
  defp number_to_text(9), do: "Nine"
  defp number_to_text(8), do: "Eight"
  defp number_to_text(7), do: "Seven"
  defp number_to_text(6), do: "Six"
  defp number_to_text(5), do: "Five"
  defp number_to_text(4), do: "Four"
  defp number_to_text(3), do: "Three"
  defp number_to_text(2), do: "Two"
end
