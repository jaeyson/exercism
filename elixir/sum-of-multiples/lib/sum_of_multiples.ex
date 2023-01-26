defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  # @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..limit
    |> Enum.filter(&check_factors(&1, factors))
    |> Enum.reject(&(&1 === limit))
    |> Enum.sum()
  end

  @spec check_factors(non_neg_integer, [non_neg_integer]) :: boolean()
  defp check_factors(num, factors) do
    factors = Enum.reject(factors, &(&1 === 0))

    case Enum.filter(factors, &(rem(num, &1) === 0)) do
      [] ->
        false

      _ ->
        true
    end
  end
end
