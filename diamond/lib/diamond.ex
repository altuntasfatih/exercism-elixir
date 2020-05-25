defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    count = letter - 65

    shape =
      Enum.to_list(65..letter)
      |> Enum.map(&List.to_string([&1]))
      |> Enum.with_index()
      |> Enum.map(&line(&1, "", count))

    [_ | tail] = Enum.reverse(shape)

    (shape ++ tail)
    |>Enum.join()
  end

  def line({character, 0}, acc, count) do
    acc <> String.duplicate(" ", count) <> character <> String.duplicate(" ", count) <> "\n"
  end

  def line({character, index}, acc, count) do
    acc <>
      String.duplicate(" ", count - index) <>
      character <>
      String.duplicate(" ", index * 2 - 1) <>
      character <> String.duplicate(" ", count - index) <> "\n"
  end
end
