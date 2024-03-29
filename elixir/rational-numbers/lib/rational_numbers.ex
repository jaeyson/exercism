defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    numerator = a1 * b2 + a2 * b1
    denominator = b1 * b2

    reduce({numerator, denominator})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    numerator = a1 * b2 - a2 * b1
    denominator = b1 * b2

    reduce({numerator, denominator})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    numerator = a1 * a2
    denominator = b1 * b2

    reduce({numerator, denominator})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, {numerator, denominator}) do
    multiply(num, {denominator, numerator})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    numerator = Kernel.abs(a)
    denominator = Kernel.abs(b)

    reduce({numerator, denominator})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0, do: pow_rational({b, a}, -n)

  def pow_rational({a, b}, n) do
    numerator = round(:math.pow(a, n))
    denominator = round(:math.pow(b, n))

    reduce({numerator, denominator})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    :math.pow(x, a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({numerator, denominator}) when denominator < 0 do
    reduce({-numerator, -denominator})
  end

  def reduce({numerator, denominator}) do
    gcd = Integer.gcd(numerator, denominator)

    {div(numerator, gcd), div(denominator, gcd)}
  end
end
