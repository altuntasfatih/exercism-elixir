defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[^\s\w-]|[_]/, "")
    |> String.split(~r/[-]|[" "]/)
    |> Enum.flat_map(&split_by_upcase/1)
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(fn x -> String.slice(x, 0, 1) end)
    |> Enum.reduce("", fn x, acc -> acc <> String.upcase(x) end)
    |> String.replace(~r/[^\w]/, "")
  end

  defp split_by_upcase(str) do
    if str == "" or String.upcase(str) == str do
      [str]
    else
      String.split(str, ~r/(?=[A-Z])/)
    end
  end
end
