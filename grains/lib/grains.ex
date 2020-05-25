defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """

  def square(number) when not (number in 1..64) do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  def square(number) do
    trunc(:math.pow(2, number - 1))
    |> ok()
  end

  def ok(number) do
    {:ok, number}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  def total do
    (-1 * (1 - trunc(:math.pow(2, 64))))
    |> ok()
  end
end
