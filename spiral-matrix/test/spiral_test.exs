defmodule SpiralTest do
  use ExUnit.Case

  test "1 dimension" do
    assert Spiral.matrix(1) == [{0, 0}]
  end

  test "2 dimension" do
    assert Spiral.matrix(2) == [{0, 0}, {0, 1}, {1, 1}, {1, 0}]
  end

  test "3 dimension" do
    assert Spiral.matrix(3) == [
             {0, 0},
             {0, 1},
             {0, 2},
             {1, 2},
             {2, 2},
             {2, 1},
             {2, 0},
             {1, 0},
             {1, 1}
           ]
  end

  test "4 dimension" do
    assert Spiral.matrix(4) == [
             {0, 0},
             {0, 1},
             {0, 2},
             {0, 3},
             {1, 3},
             {2, 3},
             {3, 3},
             {3, 2},
             {3, 1},
             {3, 0},
             {2, 0},
             {1, 0},
             {1, 1},
             {1, 2},
             {2, 2},
             {2, 1}
           ]
  end

  test "5 dimension" do
    result = Spiral.matrix(5)
    assert length(result) == 25

    assert result == [
             {0, 0},
             {0, 1},
             {0, 2},
             {0, 3},
             {0, 4},
             {1, 4},
             {2, 4},
             {3, 4},
             {4, 4},
             {4, 3},
             {4, 2},
             {4, 1},
             {4, 0},
             {3, 0},
             {2, 0},
             {1, 0},
             {1, 1},
             {1, 2},
             {1, 3},
             {2, 3},
             {3, 3},
             {3, 2},
             {3, 1},
             {2, 1},
             {2, 2}
           ]
  end

  test "6 dimension" do
    result = Spiral.matrix(6)
    assert length(result) == 36

    assert result == [
             {0, 0},
             {0, 1},
             {0, 2},
             {0, 3},
             {0, 4},
             {0, 5},
             {1, 5},
             {2, 5},
             {3, 5},
             {4, 5},
             {5, 5},
             {5, 4},
             {5, 3},
             {5, 2},
             {5, 1},
             {5, 0},
             {4, 0},
             {3, 0},
             {2, 0},
             {1, 0},
             {1, 1},
             {1, 2},
             {1, 3},
             {1, 4},
             {2, 4},
             {3, 4},
             {4, 4},
             {4, 3},
             {4, 2},
             {4, 1},
             {3, 1},
             {2, 1},
             {2, 2},
             {2, 3},
             {3, 3},
             {3, 2}
           ]
  end

  @tag :pending
  test "empty spiral" do
    assert Spiral.matrix(0) == []
  end

  @tag :pending
  test "trivial spiral" do
    assert Spiral.matrix(1) == [[1]]
  end

  @tag :pending
  test "spiral of side length 2" do
    assert Spiral.matrix(2) == [
             [1, 2],
             [4, 3]
           ]
  end

  @tag :pending
  test "spiral of side length 3" do
    assert Spiral.matrix(3) == [
             [1, 2, 3],
             [8, 9, 4],
             [7, 6, 5]
           ]
  end

  @tag :pending
  test "spiral of side length 4" do
    assert Spiral.matrix(4) == [
             [1, 2, 3, 4],
             [12, 13, 14, 5],
             [11, 16, 15, 6],
             [10, 9, 8, 7]
           ]
  end

  @tag :pending
  test "spiral of size 5" do
    assert Spiral.matrix(5) == [
             [1, 2, 3, 4, 5],
             [16, 17, 18, 19, 6],
             [15, 24, 25, 20, 7],
             [14, 23, 22, 21, 8],
             [13, 12, 11, 10, 9]
           ]
  end
end
