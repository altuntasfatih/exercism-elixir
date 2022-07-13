defmodule BasketballWebsite do
  def extract_from_path(data, path) when is_binary(path) do
    [k | tail] = keys(path)
    extract(data[k], tail)
  end

  defp extract(nil, _), do: nil
  defp extract(data, []), do: data
  defp extract(data, [head | tail]), do: extract(data[head], tail)

  def get_in_path(data, path) do
    Kernel.get_in(data, keys(path))
  end

  defp keys(path) do
    String.split(path, ".", trim: true)
  end
end
