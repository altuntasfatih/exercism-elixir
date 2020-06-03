defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defguard is_valid_side(s) when s > 0

  defguard is_valid_triangle(a, b, c)
           when   a + b > c and
                  b + c > a and
                  c + a > b

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    find_kind(a, b, c)
  end

  defp find_kind(a, b, c)
       when not is_valid_side(a) or not is_valid_side(b) or not is_valid_side(c) do
    {:error, "all side lengths must be positive"}
  end

  defp find_kind(a, b, c) when not is_valid_triangle(a, b, c) do
    {:error, "side lengths violate triangle inequality"}
  end

  defp find_kind(x, x, x) do
    {:ok, :equilateral}
  end

  defp find_kind(x, x, _b) do
    {:ok, :isosceles}
  end

  defp find_kind(_b, x, x) do
    {:ok, :isosceles}
  end

  defp find_kind(x, _b, x) do
    {:ok, :isosceles}
  end

  defp find_kind(_, _, _) do
    {:ok, :scalene}
  end
end
