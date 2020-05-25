defmodule TwelveDays do
  @doc """
  //verse ->(n) ayet
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @verse_header "On the {} day of Christmas my true love gave to me:"
  @day_to_verse %{
    1 => {"first", " a Partridge in a Pear Tree."},
    2 => {"second", " two Turtle Doves, and a Partridge in a Pear Tree."},
    3 => {"third", " three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    4 =>
      {"fourth",
       " four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    5 =>
      {"fifth",
       " five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    6 =>
      {"sixth",
       " six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    7 =>
      {"seventh",
       " seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    8 =>
      {"eighth",
       " eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    9 =>
      {"ninth",
       " nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    10 =>
      {"tenth",
       " ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    11 =>
      {"eleventh",
       " eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."},
    12 =>
      {"twelfth",
       " twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."}
  }
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    {day, text} = Map.get(@day_to_verse, number)
    String.replace(@verse_header, "{}", day) <> text
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.to_list()
    |> Enum.map_join("\n", &verse(&1))
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1,12)
  end
end
