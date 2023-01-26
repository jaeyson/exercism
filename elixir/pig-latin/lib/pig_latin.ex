defmodule PigLatin do
  @special_double_cons ~w((x|y\)[^aeiou])
  @vowels ~w(a e i o u)
  @group_cons ~w(ch rh sch squ thr th qu)
  @consonant ~w([^aeiou]+)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(<<x::binary-size(1), "y">>), do: ~s(y#{x}ay)

  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map_join(" ", &do_translate/1)
  end

  def do_translate(phrase) do
    [
      {:no_swap, @special_double_cons},
      {:no_swap, @vowels},
      {:swap, @group_cons},
      {:swap, @consonant}
    ]
    |> Enum.map(fn {action, patterns} ->
      {action, Enum.map(patterns, &Regex.compile!("\\b#{&1}"))}
    end)
    |> add_suffix(phrase)
  end

  defp add_suffix(modes, phrase) do
    {action, patterns} =
      modes
      |> Enum.filter(fn {_action, patterns} ->
        Enum.any?(patterns, &Regex.match?(&1, phrase))
      end)
      |> hd()

    patterns
    |> Enum.reduce_while("", fn pattern, acc ->
      if String.match?(phrase, pattern) do
        acc =
          case action do
            :swap ->
              phrase
              |> String.split(pattern, trim: true, include_captures: true)
              |> Enum.reverse()

            :no_swap ->
              phrase
          end
          |> to_string()
          |> Kernel.<>("ay")

        {:halt, acc}
      else
        {:cont, acc}
      end
    end)
  end
end
