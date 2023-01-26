defmodule GuessingGame do
  def compare(_n, guess \\ nil)
  def compare(_n, guess)
      when not is_integer(guess),
      do: "Make a guess"

  def compare(n, guess)
      when abs(n - guess) === 1,
      do: "So close"

  def compare(n, guess) when n < guess, do: "Too high"
  def compare(n, guess) when n > guess, do: "Too low"
  def compare(n, guess) when n === guess, do: "Correct"
end
