defmodule Bob do

  def hey(input) do
    exclamation_mark =
      input
      |> String.upcase()
      |> Kernel.!==(String.downcase(input))
      |> Kernel.&&(String.upcase(input) === input)

    question_mark =
      input
      |> String.trim()
      |> String.ends_with?("?")

    empty = String.trim(input) === ""

    cond do
      empty -> "Fine. Be that way!"
      question_mark && exclamation_mark -> "Calm down, I know what I'm doing!"
      question_mark -> "Sure."
      exclamation_mark -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
