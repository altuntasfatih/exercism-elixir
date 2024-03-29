defmodule BirdCount do
  def today([]), do: nil
  def today([today | _]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | days]), do: [today + 1 | days]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | days]), do: has_day_without_birds?(days)

  def total(list), do: total(list, 0)
  defp total([count | tail], acc), do: total(tail, acc + count)
  defp total([], acc), do: acc

  def busy_days(list), do: busy_days(list, 0)

  defp busy_days([], acc), do: acc
  defp busy_days([count | tail], acc), do: busy_days(tail, busy(count, acc))

  defp busy(count, acc) when count >= 5, do: acc + 1
  defp busy(_, acc), do: acc
end
