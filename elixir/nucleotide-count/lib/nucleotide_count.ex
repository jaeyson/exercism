defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count('', _nucleotide), do: 0

  def count(strand, nucleotide) do
    Enum.filter(strand, &(&1 === nucleotide)) |> length
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(''), do: Map.new(@nucleotides, &{&1, 0})

  def histogram(strand) do
    @nucleotides
    |> Map.new(fn nucleotide ->
      {
        nucleotide,
        Enum.count(strand, &(&1 === nucleotide))
      }
    end)
  end
end
