defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, from} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    to = NaiveDateTime.add(from, 1_000_000_000, :second)
    {{to.year, to.month, to.day}, {to.hour, to.minute, to.second}}
  end
end
