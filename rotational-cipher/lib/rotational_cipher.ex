defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> Enum.map(fn ch -> rotate_charcter(ch, shift) end)
    |> List.to_string()
  end

  def rotate_charcter(ch, shift) when ch in ?a..?z do
    ?a + rem(abs(?a - (ch + shift)), 26)
  end

  def rotate_charcter(ch, shift) when ch in ?A..?Z do
    ?A + rem(abs(?A - (ch + shift)), 26)
  end

  def rotate_charcter(ch, _shift) do
    ch
  end
end
