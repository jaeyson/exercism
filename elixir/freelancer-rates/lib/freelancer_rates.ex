defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * 8.0

  def apply_discount(before_discount, discount) do
    percentage = discount * 0.01
    before_discount - (before_discount * percentage)
  end

  def monthly_rate(hourly_rate, discount) do
    daily_rate = daily_rate(hourly_rate)

    (daily_rate * 22)
    |> apply_discount(discount)
    |> Float.ceil()
    |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate = daily_rate(hourly_rate)

    budget / apply_discount(daily_rate, discount)
    |> Float.floor(1)
  end
end
