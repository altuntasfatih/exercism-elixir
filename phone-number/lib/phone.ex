defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    if String.match?(raw, ~r/[a-zA-Z]/iu) do
      "0000000000"
    else
      raw = String.replace(raw, ~r/[^\d]/iu, "")
      number(raw, String.length(raw))
    end
  end

  def number(_, length) when length < 10, do: "0000000000"

  def number(pure, length) when length == 10 do
    with {n1, _} <- Integer.parse(String.slice(pure, 0, 1)),
         {n2, _} <- Integer.parse(String.slice(pure, 3, 1)) do
      number(pure, n1, n2)
    end
  end

  def number(pure, length) when length == 11 do
    case String.slice(pure, -11, 1) do
      "1" -> number(String.slice(pure, -10, 10), 10)
      _ -> "0000000000"
    end
  end

  def number(pure, n1, n2) when n1 > 1 and n2 > 1, do: pure
  def number(_, _, _), do: "0000000000"

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    {area_code, _, _} =
      number(raw)
      |> split_number

    area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """

  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    {area_code, second_part, third_part} = number(raw) |> split_number()
    "(#{area_code}) #{second_part}-#{third_part}"
  end

  defp split_number(<<area_code::bytes-size(3), second::bytes-size(3), third::bytes-size(4)>>) do
    {area_code, second, third}
  end
end
