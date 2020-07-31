defmodule ArmstrongNumberTest do
  use ExUnit.Case

  test "Zero is an Armstrong number" do
    assert ArmstrongNumber.valid?(0)
  end

  test "Single digit numbers are Armstrong numbers" do
    assert ArmstrongNumber.valid?(5)
  end

  test "There are no 2 digit Armstrong Numbers" do
    refute ArmstrongNumber.valid?(10)
  end

  test "Three digit number that is an Armstrong number" do
    assert ArmstrongNumber.valid?(153)
  end

  test "Three digit number that is not an Armstrong number" do
    refute ArmstrongNumber.valid?(100)
  end

  test "Four digit number that is an Armstrong number" do
    assert ArmstrongNumber.valid?(9474)
  end

  test "Four digit number that is not an Armstrong number" do
    refute ArmstrongNumber.valid?(9475)
  end

  test "Seven digit number that is an Armstrong number" do
    assert ArmstrongNumber.valid?(9_926_315)
  end

  test "Seven digit number that is not an Armstrong number" do
    refute ArmstrongNumber.valid?(9_926_134)
  end
end
