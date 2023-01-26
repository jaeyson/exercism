defmodule Secrets do
  @moduledoc false

  def secret_add(secret) do
    fn another_secret ->
      another_secret + secret
    end
  end

  def secret_subtract(secret) do
    fn another_secret ->
      another_secret - secret
    end
  end

  def secret_multiply(secret) do
    fn another_secret ->
      another_secret * secret
    end
  end

  def secret_divide(secret) do
    fn another_secret ->
      div(another_secret, secret)
    end
  end

  def secret_and(secret) do
    fn another_secret ->
      Bitwise.band(another_secret, secret)
    end
  end

  def secret_xor(secret) do
    fn another_secret ->
      Bitwise.bxor(another_secret, secret)
    end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn secret ->
      secret
      |> secret_function1.()
      |> secret_function2.()
    end
  end
end
