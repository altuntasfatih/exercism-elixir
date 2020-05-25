defmodule Say do
  @doc """
  Translate a positive integer into English.
  """

  def in_english(number) when number > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(number) when number < 0, do: {:error, "number is out of range"}
  def in_english(0), do: {:ok, "zero"}

  def in_english(number) do
    in_english(number, "")
    |> result()
  end

  defp result(s) do
    s = String.trim(s)

    if String.slice(s, -1..-1) == "-" do
      {:ok, String.slice(s, 0..-2)}
    else
      {:ok, s}
    end
  end

  def in_english(0, acc), do: acc
  def in_english(1, acc), do: acc <> "one "
  def in_english(2, acc), do: acc <> "two "
  def in_english(3, acc), do: acc <> "three "
  def in_english(4, acc), do: acc <> "four "
  def in_english(5, acc), do: acc <> "five "
  def in_english(6, acc), do: acc <> "six "
  def in_english(7, acc), do: acc <> "seven "
  def in_english(8, acc), do: acc <> "eight "
  def in_english(9, acc), do: acc <> "nine "
  def in_english(10, acc), do: acc <> "ten"
  def in_english(11, acc), do: acc <> "eleven"
  def in_english(12, acc), do: acc <> "twelve"
  def in_english(13, acc), do: acc <> "thirteen"
  def in_english(14, acc), do: acc <> "fourteen"
  def in_english(15, acc), do: acc <> "fifteen"
  def in_english(16, acc), do: acc <> "sixteen"
  def in_english(17, acc), do: acc <> "seventeen"
  def in_english(18, acc), do: acc <> "eighteen"
  def in_english(19, acc), do: acc <> "nineteen"

  def in_english(number, acc) when number >= 1_000_000_000 do
    factor = div(number, 1_000_000_000)
    in_english(number - factor * 1_000_000_000, acc <> in_english(factor, "") <> "billion ")
  end

  def in_english(number, acc) when number >= 1_000_000 do
    factor = div(number, 1_000_000)
    in_english(number - factor * 1_000_000, acc <> in_english(factor, "") <> "million ")
  end

  def in_english(number, acc) when number >= 1000 do
    factor = div(number, 1000)
    in_english(number - factor * 1000, acc <> in_english(factor, "") <> "thousand ")
  end

  def in_english(number, acc) when number >= 100 do
    factor = div(number, 100)
    in_english(number - factor * 100, acc <> in_english(factor, "") <> "hundred ")
  end

  def in_english(number, acc) when number >= 90 do
    in_english(number - 90, acc <> "ninety-")
  end

  def in_english(number, acc) when number >= 90 do
    in_english(number - 90, acc <> "ninety-")
  end

  def in_english(number, acc) when number >= 80 do
    in_english(number - 80, acc <> "eighty-")
  end

  def in_english(number, acc) when number >= 70 do
    in_english(number - 70, acc <> "seventy-")
  end

  def in_english(number, acc) when number >= 60 do
    in_english(number - 60, acc <> "sixty-")
  end

  def in_english(number, acc) when number >= 50 do
    in_english(number - 50, acc <> "fifty-")
  end

  def in_english(number, acc) when number >= 40 do
    in_english(number - 40, acc <> "forty-")
  end

  def in_english(number, acc) when number >= 30 do
    in_english(number - 30, acc <> "thirty-")
  end

  def in_english(number, acc) when number >= 30 do
    in_english(number - 30, acc <> "thirty-")
  end

  def in_english(number, acc) when number >= 20 do
    in_english(number - 20, acc <> "twenty-")
  end
end
