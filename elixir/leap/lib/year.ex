defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  def leap_year?(year) do
    do_leap_year(Integer.mod(year, 400), Integer.mod(year, 100), Integer.mod(year, 4))
  end

  defp do_leap_year(_, n, 0) when n !== 0, do: true
  defp do_leap_year(0, _, _), do: true
  defp do_leap_year(_, _, _), do: false
end
