defmodule LibraryFees do
  @day_in_second 24 * 60 * 60
  @noon ~T[12:00:00]
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime),
    do: Time.compare(NaiveDateTime.to_time(datetime), @noon) == :lt

  def return_date(checkout_datetime) do
    day = if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.add(checkout_datetime, day * @day_in_second)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(%{year: year, month: month, day: day}) do
    Date.day_of_week(Date.new!(year, month, day)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    expected_return = datetime_from_string(checkout) |> return_date()
    actual_return = datetime_from_string(return)

    (days_late(expected_return, actual_return) * rate)
    |> then(fn f -> if monday?(actual_return), do: floor(f * 0.5), else: f end)
  end
end
