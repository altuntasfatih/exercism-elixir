defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @wink 1
  @double_blink 2
  @close_your_eyes 4
  @jump 8
  @reverse 0x10

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    commands(code, false, [])
  end

  def commands(0, true, acc) do
    acc
    |> Enum.reverse()
  end

  def commands(0, false, acc), do: acc

  def commands(code, _, acc) when code >= @reverse do
    commands(code && @reverse, true, acc)
  end

  def commands(code, reverse, acc) when code >= @jump do
    commands(code - @jump, reverse, ["jump" | acc])
  end

  def commands(code, reverse, acc) when code >= @close_your_eyes do
    commands(code - @close_your_eyes, reverse, ["close your eyes" | acc])
  end

  def commands(code, reverse, acc) when code >= @double_blink do
    commands(code - @double_blink, reverse, ["double blink" | acc])
  end

  def commands(code, reverse, acc) when code >= @double_blink do
    commands(code - @double_blink, reverse, ["double blink" | acc])
  end

  def commands(code, reverse, acc) when code >= @wink do
    commands(code - @wink, reverse, ["wink" | acc])
  end
end
