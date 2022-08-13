defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{
      input: input,
      pid:
        spawn_link(fn ->
          calculator.(input)
        end)
    }
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    flag = Keyword.get(Process.info(self()), :trap_exit)
    Process.flag(:trap_exit, flag or true)
    result = run_reliability_check(calculator, inputs)
    Process.flag(:trap_exit, flag or false)
    result
  end

  defp run_reliability_check(calculator, inputs) do
    Enum.map(inputs, &start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
  end

  def correctness_check(calculator, inputs) do
    Enum.map(inputs, fn input ->
      Task.async(fn ->
        calculator.(input)
      end)
    end)
    |> Enum.map(&Task.await(&1, 100))
  end
end
