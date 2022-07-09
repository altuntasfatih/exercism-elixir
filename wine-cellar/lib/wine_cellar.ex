defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ [])
  def filter(cellar, color, opts), do: Keyword.get_values(cellar, color) |> filter_by_opts(opts)

  defp filter_by_opts(cellar, [{:year, year} | tail]),
    do: cellar |> filter_by_year(year) |> filter_by_opts(tail)

  defp filter_by_opts(cellar, [{:country, country} | tail]),
    do: cellar |> filter_by_country(country) |> filter_by_opts(tail)

  defp filter_by_opts(cellar, []), do: cellar

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
