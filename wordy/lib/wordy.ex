defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @operation %{"+" => &Kernel.+/2, "-" => &Kernel.-/2, "*" => &Kernel.*/2, "/" => &Kernel.//2}

  @spec answer(String.t()) :: integer
  def answer(question) do
    if String.match?(question, ~r/(^What\sis.+?$)/) do
      tokenize(question)
    else
      raise ArgumentError
    end
  end

  def tokenize(expression) do
    String.slice(expression, 8..-2)
    |> String.replace("multiplied by", "*")
    |> String.replace("divided by", "/")
    |> String.replace("plus", "+")
    |> String.replace("minus", "-")
    |> String.split()
    |> Enum.map(fn x -> parse(x) end)
    |> evaluate(nil)
  end

  def parse(exp) do
    cond do
      Map.has_key?(@operation, exp) -> {:operation, Map.get(@operation, exp)}
      String.match?(exp, ~r/^-?\d+$/) -> {:integer, String.to_integer(exp)}
      true -> raise ArgumentError
    end
  end

  def evaluate([], acc), do: acc
  def evaluate([{:integer, number} | tail], nil), do: evaluate(tail, number)

  def evaluate([{:operation, func} | [{:integer, operand} | t]], acc) do
    evaluate(t, func.(acc, operand))
  end
end
