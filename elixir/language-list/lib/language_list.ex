defmodule LanguageList do
  @moduledoc false

  @spec new :: list
  def new, do: []

  @spec add(list, String.t()) :: list(String.t())
  def add(list, language), do: [language | list]

  @spec remove(list) :: list(String.t())
  def remove([_h | t]), do: t

  @spec first(list) :: String.t()
  def first([h | _t]), do: h

  @spec count(list) :: integer
  def count(list), do: do_count(list, 0)

  @spec functional_list?(list) :: boolean
  def functional_list?(list), do: "Elixir" in list

  @spec do_count(list, integer) :: integer
  defp do_count([], n), do: n
  defp do_count([_h | t], n), do: do_count(t, n + 1)
end
