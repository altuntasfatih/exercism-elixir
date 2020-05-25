defmodule OCRNumbers do

  @map %{
    [' _ ',
     '| |',
     '|_|',
     '   '] => 0,
    ['   ',
     '  |',
     '  |',
     '   '] => 1,
    [' _ ',
     ' _|',
     '|_ ',
     '   '] => 2,
    [' _ ',
     ' _|',
     ' _|',
     '   '] => 3,
    ['   ',
     '|_|',
     '  |',
     '   '] => 4,
    [' _ ',
     '|_ ',
     ' _|',
     '   '] => 5,
    [' _ ',
     '|_ ',
     '|_|',
     '   '] => 6,
    [' _ ',
     '  |',
     '  |',
     '   '] => 7,
    [' _ ',
     '|_|',
     '|_|',
     '   '] => 8,
    [' _ ',
     '|_|',
     ' _|',
     '   '] => 9
  }

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t]) :: String.t
  def convert(input) when rem(length(input), 4) != 0, do: {:error, 'invalid line count'}
  def convert(input) when rem(byte_size(hd(input)), 3) != 0, do: {:error, 'invalid column count'}
  def convert(input) do
    r = input
    |> Enum.chunk(4)
    |> Enum.map_join(",", &to_digits/1)

    {:ok, r}
  end

  defp to_digits(input) do
    rows = input
    |> Enum.map(fn(row) -> row |> to_charlist |> Enum.chunk(3) end)
    |> Enum.zip

    for {r1, r2, r3, r4} <- rows, into: "", do: to_string(Map.get(@map, [r1, r2, r3, r4], "?"))
  end
end
