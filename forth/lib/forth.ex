defmodule Forth do
  @instructions ["dup", "drop", "swap", "over", "+", "-", "*", "/"]

  @opaque evaluator :: %Forth{}
  defstruct stack: [], words: %{}

  @doc """
  Create a new evaluator.
  """

  @spec new() :: evaluator
  def new() do
    %Forth{}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    String.downcase(s)
    |> tokenize(ev.words)
    |> evaluate(ev)
  end

  defp tokenize(exp, words) do
    exp
    |> String.replace(~r/[^\w\+-\\*\/]| /, " ")
    |> String.split()
    |> tokens(words, [])
    |> Enum.reverse()
  end

  defp tokens([], _, acc), do: acc

  defp tokens([h | t], words, acc) do
    cond do
      h == ":" ->
        {rest, definition} = extract_word(t)
        tokens(rest, words, [definition | acc])

      Map.get(words, h) != nil ->
        tokens(t, words, [{:word, h} | acc])

      true ->
        tokens(t, words, [instruction(h) | acc])
    end
  end

  defp extract_word([key | tail]) do
    if String.match?(key, ~r/\D+$/) do
      {data, rest} = extract_word(tail, [])
      {rest, {:define, key, data}}
    else
      raise(Forth.InvalidWord, word: key)
    end
  end

  defp extract_word([";" | t], acc), do: {Enum.map(acc, &instruction/1), t}
  defp extract_word([h | t], acc), do: extract_word(t, [h | acc])

  defp instruction(word) do
    cond do
      word in @instructions -> {:instruction, String.downcase(word)}
      String.match?(word, ~r/^\d+$/) -> {:integer, String.to_integer(word)}
      true -> {:word, word}
    end
  end

  @spec evaluate([any], any) :: any
  def evaluate([{:integer, data} | tail], ev) do
    evaluate(tail, %Forth{ev | stack: [data | ev.stack]})
  end

  def evaluate([{:define, key, data} | tail], ev) do
    evaluate(tail, %Forth{ev | words: Map.put(ev.words, key, data)})
  end

  def evaluate([{:word, key} | tail], ev) do
    case Map.get(ev.words, key) do
      nil -> raise(Forth.UnknownWord)
      word -> evaluate(word ++ tail, ev)
    end
  end

  def evaluate([{:instruction, i} | tail], ev) do
    case i do
      "+" -> evaluate(tail, %Forth{ev | stack: add(ev.stack)})
      "-" -> evaluate(tail, %Forth{ev | stack: sub(ev.stack)})
      "*" -> evaluate(tail, %Forth{ev | stack: multiply(ev.stack)})
      "/" -> evaluate(tail, %Forth{ev | stack: divide(ev.stack)})
      "dup" -> evaluate(tail, %Forth{ev | stack: dup(ev.stack)})
      "drop" -> evaluate(tail, %Forth{ev | stack: drop(ev.stack)})
      "swap" -> evaluate(tail, %Forth{ev | stack: swap(ev.stack)})
      "over" -> evaluate(tail, %Forth{ev | stack: over(ev.stack)})
    end
  end

  def evaluate([], acc), do: acc

  defp add([b | [a | t]]), do: [a + b | t]
  defp sub([b | [a | t]]), do: [a - b | t]
  defp multiply([b | [a | t]]), do: [a * b | t]
  defp divide([0 | [_ | _]]), do: raise(Forth.DivisionByZero)
  defp divide([b | [a | t]]), do: [trunc(a / b) | t]
  defp dup([]), do: raise(Forth.StackUnderflow)
  defp dup([a | _] = stack), do: [a | stack]
  defp drop([]), do: raise(Forth.StackUnderflow)
  defp drop([_ | t]), do: t
  defp swap(stack) when length(stack) < 2, do: raise(Forth.StackUnderflow)
  defp swap([b | [a | t]]), do: [a | [b | t]]

  defp over(stack) when length(stack) < 2, do: raise(Forth.StackUnderflow)
  defp over([_ | [a | _]] = stack), do: [a | stack]

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev) do
    ev.stack
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
