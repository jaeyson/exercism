defmodule ProteinTranslation do
  @moduledoc false

  @translation %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(""), do: {:ok, []}

  def of_rna(rna) do
    # codons = for <<codon::binary - 3 <- rna>>, do: codon
    codons =
      rna
      |> String.split("", trim: true)
      |> Enum.chunk_every(3)
      |> Enum.map(&to_string/1)

    proteins =
      codons
      |> Enum.reduce_while([], fn codon, acc ->
        case translate(codon) do
          "STOP" -> {:halt, acc}
          _ -> {:cont, [translate(codon) | acc]}
        end
      end)

    valid_codon? = Enum.any?(proteins, &(&1 === nil))

    case valid_codon? do
      true -> {:error, "invalid RNA"}
      false -> {:ok, Enum.reverse(proteins)}
    end
  end

  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case translate(codon) do
      nil -> {:error, "invalid codon"}
      _ -> {:ok, translate(codon)}
    end
  end

  @spec translate(String.t()) :: String.t()
  def translate(codon), do: @translation[codon]
end
