defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[DEBUG|INFO|WARNING|ERROR\]/
  end

  def split_line(line) do
    r = ~r/(<[\*\~\=\-]*>)/
    String.split(line, r)
  end

  def remove_artifacts(line) do
    r = ~r/(end-of-line[\d]+)/i
    String.replace(line, r, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s*(\S+)/, line) do
      [capture | _] ->
        "[USER] " <> (String.slice(capture, 4..-1) |> String.trim()) <> " " <> line

      _ ->
        line
    end
  end
end
