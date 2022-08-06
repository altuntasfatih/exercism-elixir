defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception([]), do: %StackUnderflowError{}

    def exception(context),
      do: %StackUnderflowError{message: "stack underflow occurred, context: #{context}"}
  end

  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([division, dividend]), do: dividend / division
  def divide(_), do: raise(StackUnderflowError, "when dividing")
end
