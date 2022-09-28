defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({real, _}), do: real

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, imaginary}), do: imaginary

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul({r1, i1}, {r2, i2}) do
    real = r1 * r2 - i1 * i2
    imag = r1 * i2 + i1 * r2
    {real, imag}
  end

  def mul({r, i}, number), do: {r * number, i * number}
  def mul(number, {r, i}), do: {r * number, i * number}

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add({r1, i1}, {r2, i2}) do
    {r1 + r2, i1 + i2}
  end

  def add({r, i}, number), do: {r + number, i}
  def add(number, {r, i}), do: {r + number, i}

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub({r1, i1}, {r2, i2}) do
    {r1 - r2, i1 - i2}
  end

  def sub({r, i}, number), do: {r - number, i}
  def sub(number, {r, i}), do: {number - r, -i}

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div(c1, {r2, i2} = c2) do
    divisor = r2 * r2 + i2 * i2
    {r, i} = mul(c1, conjugate(c2))
    {r / divisor, i / divisor}
  end

  def div({r, i}, number), do: {r / number, i / number}
  def div(number, {r, i}), do: {r / number, i / number}

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({r, i}), do: :math.sqrt(r * r + i * i)

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({r, i}), do: {r, -1 * i}

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({r, i}) do
    m = :math.exp(r)
    c = {:math.cos(i), :math.sin(i)}

    mul(m, c)
  end
end
