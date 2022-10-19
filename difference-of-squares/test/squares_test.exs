defmodule SquaresTest do
  use ExUnit.Case

  describe "square_of_sum" do
    test "square of sum to 1" do
      assert Squares.square_of_sum(1) == 1
    end

    test "square of sum to 5" do
      assert Squares.square_of_sum(5) == 225
    end

    test "square of sum to 100" do
      assert Squares.square_of_sum(100) == 25_502_500
    end
  end

  describe "sum_of_squares" do
    test "sum of squares to 1" do
      assert Squares.sum_of_squares(1) == 1
    end

    test "sum of squares to 5" do
      assert Squares.sum_of_squares(5) == 55
    end

    test "sum of squares to 100" do
      assert Squares.sum_of_squares(100) == 338_350
    end
  end

  describe "difference" do
    test "difference of sum to 1" do
      assert Squares.difference(1) == 0
    end

    test "difference of sum to 5" do
      assert Squares.difference(5) == 170
    end

    test "difference of sum to 100" do
      assert Squares.difference(100) == 25_164_150
    end
  end
end
