defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @day_to_index %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @one_week 7
  @two_week 14
  @three_week 21

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    {:ok, date} = Date.new(year, month, 1)

    update_day(date, weekday)
    |> update_week(schedule)
  end

  defp update_week(date, :first), do: date
  defp update_week(date, :second), do: Date.add(date, @one_week)
  defp update_week(date, :third), do: Date.add(date, @two_week)
  defp update_week(date, :fourth), do: Date.add(date, @three_week)

  defp update_week(date, :last) do
    diffrence = div(Date.days_in_month(date) - date.day, @one_week) * @one_week
    Date.add(date, diffrence)
  end

  defp update_week(date, :teenth) do
    if date.day < 6 do
      Date.add(date, @two_week)
    else
      Date.add(date, @one_week)
    end
  end

  defp update_day(date, target_day) do
    day_of_week = Date.day_of_week(date)
    Date.add(date, day_gap(day_of_week, Map.get(@day_to_index, target_day)))
  end

  defp day_gap(day_of_week, day_of_week), do: 0
  defp day_gap(day_of_week, target_day), do: rem(@one_week - day_of_week + target_day, @one_week)
end
