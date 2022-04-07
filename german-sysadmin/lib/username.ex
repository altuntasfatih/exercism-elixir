defmodule Username do
  def sanitize(username) do
    sanitize(username, [])
  end

  defp sanitize([char | tail], acc) when char >= ?a and char <= ?z do
    sanitize(tail, [char | acc])
  end

  defp sanitize([char | tail], acc) do
    case char do
      ?ä -> sanitize(tail, [?e | [?a | acc]])
      ?ü -> sanitize(tail, [?e | [?u | acc]])
      ?ö -> sanitize(tail, [?e | [?o | acc]])
      ?ß -> sanitize(tail, [?s | [?s | acc]])
      ?_ -> sanitize(tail, [char | acc])
      _ -> sanitize(tail, acc)
    end
  end

  defp sanitize([], acc), do: acc |> Enum.reverse()
end
