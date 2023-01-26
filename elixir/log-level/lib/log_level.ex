defmodule LogLevel do
  @moduledoc false

  @codes [
    trace: false,
    debug: true,
    info: true,
    warning: true,
    error: true,
    fatal: false
  ]

  @spec to_label(integer, boolean) :: atom
  def to_label(level, _legacy?) when level < 0, do: :unknown

  def to_label(level, legacy?) do
    cond do
      (has_code?(level) and supported?(level, true)) or
          (has_code?(level) and supported?(level, legacy?)) ->
        get_elem(level, 0)

      true ->
        :unknown
    end
  end

  @spec alert_recipient(integer, boolean) :: :atom | false
  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label in [:error, :fatal] ->
        :ops

      label === :unknown and not legacy? ->
        :dev2

      label === :unknown and legacy? ->
        :dev1

      true ->
        false
    end
  end

  @spec supported?(integer, boolean) :: boolean
  defp supported?(level, legacy?), do: get_elem(level, 1) === legacy?

  @spec has_code?(integer) :: boolean
  defp has_code?(level), do: get_elem(level, 0) in Keyword.keys(@codes)

  @spec get_elem(integer, integer) :: :atom | boolean
  defp get_elem(level, el_pos) do
    @codes
    |> Enum.at(level, {nil, false})
    |> elem(el_pos)
  end
end
