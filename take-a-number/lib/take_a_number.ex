defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(number \\ 0) do
    receive do
      {:report_state, pid} ->
        send(pid, number) |> loop()

      {:take_a_number, pid} ->
        send(pid, number + 1) |> loop()

      :stop ->
        nil

      _ ->
        loop(number)
    end
  end
end
