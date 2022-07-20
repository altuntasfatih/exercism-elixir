defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ [])

  def get_combinations(tops, bottoms, options) do
    maximum_price = Keyword.get(options, :maximum_price, 100)

    for t <- tops,
        b <- bottoms,
        t.base_color != b.base_color and t.price + b.price <= maximum_price do
      {t, b}
    end
  end
end
