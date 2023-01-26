defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    cond do
      length_positive?(a, b, c) ->
        {:error, "all side lengths must be positive"}

      equilateral?(a, b, c) ->
        {:ok, :equilateral}

      isosceles?(a, b, c) ->
        {:ok, :isosceles}

      scalene?(a, b, c) ->
        {:ok, :scalene}

      true ->
        {:error, "side lengths violate triangle inequality"}
    end
  end

  defp length_positive?(a, b, c) do
    a <= 0 or b <= 0 or c <= 0
  end

  defp equilateral?(a, b, c) do
    a === b and b === c
  end

  defp isosceles?(a, b, c) do
    valid_sides?(a, b, c) and
      not has_unique_sides?(a, b, c)
  end

  defp scalene?(a, b, c) do
    valid_sides?(a, b, c) and
      has_unique_sides?(a, b, c)
  end

  defp has_unique_sides?(a, b, c) do
    unique_sides = Enum.uniq([a, b, c])

    length(unique_sides) === length([a, b, c])
  end

  defp valid_sides?(a, b, c) do
    a + b >= c and
      a + c >= b and
      c + b >= a
  end
end
