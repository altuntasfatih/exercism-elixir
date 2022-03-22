defmodule GuessingGame do
  def compare(_, guess \\ :no_guess)
  def compare(_, :no_guess), do: "Make a guess"
  def compare(secret_number, secret_number), do: "Correct"

  def compare(secret_number, guess) when abs(secret_number - guess) == 1,
    do: "So close"

  def compare(secret_number, guess) when guess > secret_number, do: "Too high"
  def compare(secret_number, guess) when guess < secret_number, do: "Too low"
end
