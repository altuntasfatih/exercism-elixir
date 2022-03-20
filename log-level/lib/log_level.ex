defmodule LogLevel do
  def to_label(0, false), do: :trace
  def to_label(1, _), do: :debug
  def to_label(2, _), do: :info
  def to_label(3, _), do: :warning
  def to_label(4, _), do: :error

  def to_label(5, false), do: :fatal
  def to_label(_, _), do: :unknown

  def alert_recipient(level, legacy?) when is_integer(level) do
    label = to_label(level, legacy?)

    cond do
      label in [:error, :fatal] -> :ops
      label == :unknown && legacy? -> :dev1
      label == :unknown && not legacy? -> :dev2
      true -> false
    end
  end
end
