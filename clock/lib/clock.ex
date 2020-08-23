defmodule Clock do
  defstruct hour: 0, minute: 0

  @total_minute_in_one_day 24 * 60
  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    new(hour * 60 + minute)
  end

  def new(total) when total < 0 do
    total = @total_minute_in_one_day + rem(total, @total_minute_in_one_day)
    new(total)
  end

  def new(total) do
    %Clock{hour: rem(div(total, 60), 24), minute: rem(total, 60)}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour * 60 + minute + add_minute)
  end

  defimpl String.Chars, for: Clock do
    def to_string(clock) do
      "#{str(clock.hour)}:#{str(clock.minute)}"
    end

    def str(value) when value < 10, do: "0#{value}"
    def str(value), do: "#{value}"
  end
end
