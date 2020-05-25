defmodule BinaryTest do
  use ExUnit.Case

  test "binary 0 is decimal 0" do
    assert Binary.to_decimal("0") == 0
  end

  test "binary 1 is decimal 1" do
    assert Binary.to_decimal("1") == 1
  end

  test "binary 10 is decimal 2" do
    assert Binary.to_decimal("10") == 2
  end

  test "binary 11 is decimal 3" do
    assert Binary.to_decimal("11") == 3
  end

  test "binary 100 is decimal 4" do
    assert Binary.to_decimal("100") == 4
  end

  test "binary 1001 is decimal 9" do
    assert Binary.to_decimal("1001") == 9
  end
  test "binary 1010 is decimal 10" do
    assert Binary.to_decimal("1010") == 10
  end


  test "binary 11010 is decimal 26" do
    assert Binary.to_decimal("11010") == 26
  end

  test "binary 10001101000 is decimal 1128" do
    assert Binary.to_decimal("10001101000") == 1128
  end

  test "binary ignores leading zeros" do
    assert Binary.to_decimal("000011111") == 31
  end

  test "2 is not a valid binary digit" do
    assert Binary.to_decimal("2") == 0
  end

  test "a number containing a non-binary digit is invalid" do
    assert Binary.to_decimal("01201") == 0
  end

  test "a number with trailing non-binary characters is invalid" do
    assert Binary.to_decimal("10nope") == 0
  end

  test "a number with leading non-binary characters is invalid" do
    assert Binary.to_decimal("nope10") == 0
  end

  test "a number with internal non-binary characters is invalid" do
    assert Binary.to_decimal("10nope10") == 0
  end

  test "a number and a word whitespace separated is invalid" do
    assert Binary.to_decimal("001 nope") == 0
  end

  test "invalid binary is decimal 0" do
    assert Binary.to_decimal("carrot") == 0
  end

  test "invalid binary is decimal 0 II" do
    assert Binary.to_decimal("convert01") == 0
  end

  test "invalid binary is decimal 0 III" do
    assert Binary.to_decimal("10convert") == 0
  end

  test "invalid binary is decimal 0 IV" do
    assert Binary.to_decimal("1carrot0") == 0
  end

  test "22 is not a binary number" do
    assert Binary.to_decimal("22") == 0
  end
end
