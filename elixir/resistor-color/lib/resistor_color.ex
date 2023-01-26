defmodule ResistorColor do
  @moduledoc false

  @colors [
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  ]

  @spec colors() :: list(String.t())
  def colors, do: @colors

  @spec code(color :: atom) :: integer
  def code(color), do: @colors[color]
end
