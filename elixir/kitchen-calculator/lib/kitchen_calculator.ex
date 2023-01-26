defmodule KitchenCalculator do
  @unit %{
    milliliter: 1,
    cup: 240,
    fluid_ounce: 30,
    teaspoon: 5,
    tablespoon: 15
  }

  def get_volume(volume_pair), do: elem(volume_pair, 1)

  def to_milliliter({name, vol}) do
    {:milliliter, @unit[name] * vol}
  end

  def from_milliliter({:milliliter, ml}, name) do
    {name, ml / @unit[name]}
  end

  def convert({old_unit, vol}, new_unit) do
    ml = (vol * @unit[old_unit]) |> div(@unit[new_unit])
    {new_unit, ml}
  end
end
