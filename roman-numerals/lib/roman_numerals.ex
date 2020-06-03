defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    find_roman(number, "")

  end

  def find_roman(number, result) when number >= 1000 do
    find_roman(number - 1000, result <> "M")
  end

  def find_roman(number, result) when number >= 900   do
    find_roman(number - 900, result <> "CM")
  end

  def find_roman(number, result) when number >= 500 do
    find_roman(number - 500, result <> "D")
  end

  def find_roman(number, result) when number >= 400   do
    find_roman(number - 400, result <> "CD")
  end

  def find_roman(number, result) when number >= 100 do
    find_roman(number - 100, result <> "C")
  end

  def find_roman(number, result) when number >= 90  do
    find_roman(number - 90, result <> "XC")
  end

  def find_roman(number, result) when number >= 50 do
    find_roman(number - 50, result <> "L")
  end

  def find_roman(number, result) when number >= 40  do
    find_roman(number - 40, result <> "XL")
  end
  def find_roman(number, result) when number >= 10 do
    find_roman(number - 10, result <> "X")
  end
  def find_roman(number, result) when number == 9  do
    find_roman(number - 9, result <> "IX")
  end
  def find_roman(number, result) when number >= 5 do
    find_roman(number - 5, result <> "V")
  end
  def find_roman(number, result) when number == 4  do
    find_roman(number - 4, result <> "IV")
  end

  def find_roman(number, result) when number >=1 do
    find_roman(number - 1, result <> "I")
  end

  def find_roman(number, result) when number == 0 do
    result
  end
end
