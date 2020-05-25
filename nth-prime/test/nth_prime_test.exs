defmodule NthPrimeTest do
  use ExUnit.Case

  # #@tag :pending
  test "first prime" do
    assert Prime.nth(1) == 2
  end

  # @tag :pending
  test "second prime" do
    assert Prime.nth(2) == 3
  end

  test "sixth prime" do
    assert Prime.nth(6) == 13
  end

  test "100th prime" do
    assert Prime.nth(100) == 541
  end

  test "1000th prime" do
    assert Prime.nth(1000) == 7919
  end

  test "10000th prime" do
    assert Prime.nth(10000) == 104_729
  end

  test "100000th prime" do
    assert Prime.nth(100_000) == 1_299_709
  end

  test "1000000th prime" do
    assert Prime.nth(1_000_000) == 15_485_863
  end

  test "weird case" do
    catch_error(Prime.nth(0))
  end
end
