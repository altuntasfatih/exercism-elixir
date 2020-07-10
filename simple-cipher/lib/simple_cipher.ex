defmodule SimpleCipher do
  defguard is_valid_character(value) when is_integer(value) and value >= ?a and value <= ?z

  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    key = String.to_charlist(key)
    text = String.to_charlist(plaintext)
    encode(text, key, {key, []})
  end

  def encode([c | c_tail], [k | k_tail], {key, acc}) when is_valid_character(c) do
    encode(c_tail, k_tail, {key, [shift_right(c, k) | acc]})
  end

  def encode([c | c_tail], [_ | k_tail], {key, acc}) do
    encode(c_tail, k_tail, {key, [c | acc]})
  end

  def encode([], _, {_, acc}) do
    Enum.reverse(acc)
    |> to_string()
  end

  def encode(text, [], {key, acc}) do
    encode(text, key, {key, acc})
  end

  defp shift_right(c, k) do
    ?a + rem(c + (k - ?a) - ?a, 26)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    key = String.to_charlist(key)
    text = String.to_charlist(ciphertext)
    decode(text, key, {key, []})
  end

  def decode([c | c_tail], [k | k_tail], {key, acc}) when is_valid_character(c) do
    decode(c_tail, k_tail, {key, [shift_left(c, k) | acc]})
  end

  def decode([c | c_tail], [_ | k_tail], {key, acc}) do
    decode(c_tail, k_tail, {key, [c | acc]})
  end

  def decode([], _, {_, acc}) do
    Enum.reverse(acc)
    |> to_string()
  end

  def decode(text, [], {key, acc}) do
    decode(text, key, {key, acc})
  end

  defp shift_left(c, k) do
    ?z - rem(?z - (c - (k - ?a)), 26)
  end
end
