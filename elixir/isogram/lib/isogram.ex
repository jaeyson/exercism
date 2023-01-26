defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence =
      sentence
      |> String.downcase()
      |> String.replace(~r/[^[:alpha:]]/, "")
      |> String.split("", trim: true)

    sentence === Enum.uniq(sentence)
  end
end
