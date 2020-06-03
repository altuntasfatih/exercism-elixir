defmodule MatrixTest do
  use ExUnit.Case

  @input "1 2 3\n4 5 6\n7 8 9"

  @input_2 "31 32 34 35\n36 37 38 39\n40 41 42 43"

  test "reading from and writing to string" do
    matrix = Matrix.from_string(@input)
    assert Matrix.to_string(matrix) == @input
  end


  test "rows should return nested lists regardless of internal structure" do
    matrix = Matrix.from_string(@input)

    assert Matrix.rows(matrix) == [
             [1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]
           ]
  end

  test "row should return list at index" do
    matrix = Matrix.from_string(@input)

    assert Matrix.row(matrix, 0) == [1, 2, 3]
    assert Matrix.row(matrix, 1) == [4, 5, 6]
    assert Matrix.row(matrix, 2) == [7, 8, 9]
  end

  test "columns should return nested lists regardless of internal structure" do
    matrix = Matrix.from_string(@input)

    assert Matrix.columns(matrix) == [
             [1, 4, 7],
             [2, 5, 8],
             [3, 6, 9]
           ]
  end

  test "column should return list at index" do
    matrix = Matrix.from_string(@input)

    assert Matrix.column(matrix, 0) == [1, 4, 7]
    assert Matrix.column(matrix, 1) == [2, 5, 8]
    assert Matrix.column(matrix, 2) == [3, 6, 9]
  end

  test "reading from and writing to string on input_2" do
    matrix = Matrix.from_string(@input_2)
    assert Matrix.to_string(matrix) == @input_2
  end
end
