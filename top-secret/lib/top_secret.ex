defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part({op, _, [node | _]} = ast, acc) when op in [:defp, :def] do
    {ast, [extract_name(node) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    Macro.prewalk(to_ast(string), [], fn quoted, acc ->
      decode_secret_message_part(quoted, acc)
    end)
    |> then(fn {_, names} ->
      Enum.reverse(names) |> Enum.join()
    end)
  end

  defp extract_name({:when, _, [node | _]}), do: extract_name(node)

  defp extract_name({name, _, arg}) when length(arg) > 0 do
    size = length(arg) - 1
    Atom.to_string(name) |> String.slice(0..size)
  end

  defp extract_name(_), do: ""
end
