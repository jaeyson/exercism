defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    :math.sqrt(x * x + y * y) |> do_score()
  end

  defp do_score(n) when n <= 1, do: 10
  defp do_score(n) when n <= 5, do: 5
  defp do_score(n) when n <= 10, do: 1
  defp do_score(_), do: 0
end
