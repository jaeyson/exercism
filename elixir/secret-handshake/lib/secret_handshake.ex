defmodule SecretHandshake do
  require Integer

  @bits [8, 4, 2, 1]
  @limit 16

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    even? = Integer.is_even(div(code, @limit))
    mod = Integer.mod(code, @limit)

    if even?,
      do: do_commands(mod),
      else: do_commands(mod) |> Enum.reverse()
  end

  def do_commands(code) do
    cond do
      code === 0 ->
        []

      code in @bits ->
        [gen(code)]

      true ->
        {_, filtered_codes} =
          Enum.reduce_while(@bits, {code, []}, fn n, {pos, acc} ->
            cond do
              pos - n < 0 -> {:cont, {pos, acc}}
              true -> {:cont, {pos - n, [n | acc]}}
            end
          end)

        Enum.map(filtered_codes, &gen/1)
    end
  end

  def gen(1), do: "wink"
  def gen(2), do: "double blink"
  def gen(4), do: "close your eyes"
  def gen(8), do: "jump"
  def gen(_n), do: nil
end
