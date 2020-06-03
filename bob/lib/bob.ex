defmodule Bob do
  defp have_letter?(input) do
    String.upcase(input) != String.downcase(input)
  end

  defp upper_case?(input) do
    String.upcase(input) == input
  end

  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      have_letter?(input) && upper_case?(input) && String.ends_with?(input, "?") ->
        "Calm down, I know what I'm doing!"

      String.ends_with?(input, "?") ->
        "Sure."

      have_letter?(input) && upper_case?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
