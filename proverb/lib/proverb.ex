defmodule Proverb do
  @doc """
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite([head | tail]) do
    Enum.reduce(tail, {head, ""}, fn str, {pre, proverb} ->
      {str, proverb <> "For want of a #{pre} the #{str} was lost.\n"}
    end)
    |> then(fn {_, proverb} ->
      proverb <> "And all for the want of a #{head}.\n"
    end)
  end
end
