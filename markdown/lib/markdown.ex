defmodule Markdown do
  @header_md "#"
  @list_md "*"
  @strong_md "__"
  @md "_"

  defp italic_open(str), do: "<em>" <> str
  defp italic_close(str), do: str <> "</em>"
  defp strong_open(str), do: "<strong>" <> str
  defp strong_close(str), do: str <> "</strong>"
  defp list_item(str), do: "<li>" <> String.trim(str) <> "</li>"
  defp paragraph(str), do: "<p>" <> String.trim(str) <> "</p>"
  defp header(str, count), do: "<h#{count}>" <> String.trim(str) <> "</h#{count}>"

  # Edit pipe operator to make clear
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    String.split(m, "\n")
    |> Enum.map_join(&process_line/1)
    |> update_list_md()
  end

  defp process_line(@header_md <> rest) do
    enclose_with_header_tag(rest,1)
  end

  defp process_line(line = @list_md <> _) do
    enclose_with_list_tag(line)
  end

  defp process_line(line) do
    String.split(line)
    |> enclose_with_paragraph_tag()
  end

  defp enclose_with_header_tag(@header_md <> rest,acc) do
    enclose_with_header_tag(rest,acc+1)
  end
  defp enclose_with_header_tag(rest,acc) do
    header(rest, acc)
  end

  defp enclose_with_list_tag(l) do
    String.trim_leading(l, "* ")
    |> String.split()
    |> join_words_with_tags()
    |> list_item()
  end

  defp enclose_with_paragraph_tag(t) do
    join_words_with_tags(t)
    |> paragraph()
  end

  defp join_words_with_tags(str) do
    Enum.reduce(str, {[], false}, fn word, {result, flag} ->
      {word, flag} = process_word(word, flag)
      {[word | result], flag}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp process_word(word = @md <> _, flag) do
    if String.ends_with?(word, @md) do
      word = replace_md_with_tag(word, flag) |> replace_md_with_tag(not flag)
      {word, false}
    else
      {replace_md_with_tag(word, flag), true}
    end
  end

  defp process_word(word, flag) do
    if String.ends_with?(word, @md) do
      {replace_md_with_tag(word, flag), false}
    else
      {word, flag}
    end
  end

  defp replace_md_with_tag(word, false) do
    if String.starts_with?(word, @strong_md) do
      String.slice(word, 2..-1)
      |> strong_open()
    else
      String.slice(word, 1..-1)
      |> italic_open()
    end
  end

  defp replace_md_with_tag(word, true) do
    if String.ends_with?(word, @strong_md) do
      String.slice(word, 0..-3)
      |> strong_close()
    else
      String.slice(word, 0..-2)
      |> italic_close()
    end
  end

  defp update_list_md(markdown) do
    markdown
    |> String.replace(~r/<li>.*<\/li>/,"<ul>\\0</ul>")
  end
end
