defmodule LanguageList do
  def new(), do: []
  def add(list, language), do: [language | list]
  def remove([_ | tail]), do: tail
  def first([head | _]), do: head
  def count(list), do: count(list, 0)
  def count([], acc), do: acc
  def count([_ | t], acc), do: count(t, acc + 1)

  def exciting_list?(list), do: "Elixir" in list
end
