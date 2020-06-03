defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @brackets_pair ["()", "[]", "{}"]
  def check_brackets(str) do
    str
    |> String.replace(~r/[^{}()\[\]]/, "")
    |> match?()
  end

  defp match?(nil), do: false

  defp match?(""), do: true

  defp match?(str) do
    Enum.filter(@brackets_pair, fn pair -> String.contains?(str, pair) end)
    |> modify(str)
    |> match?()
  end

  defp modify([], _), do: nil

  defp modify(patterns, str) do
    Enum.reduce(patterns, str, fn pattern, str -> String.replace(str, pattern, "") end)
  end
end
