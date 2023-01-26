defmodule Lasagna do
  def expected_minutes_in_oven,
    do: expected_minutes_in_oven(40)

  def expected_minutes_in_oven(minutes), do: minutes

  def remaining_minutes_in_oven(minutes),
    do: expected_minutes_in_oven() - minutes

  def preparation_time_in_minutes(minutes),
    do: minutes * 2

  def total_time_in_minutes(layer, minutes),
    do: minutes + preparation_time_in_minutes(layer)

  def alarm, do: "Ding!"
end
