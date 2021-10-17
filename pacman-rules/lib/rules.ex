defmodule Rules do
  def eat_ghost?(true, true), do: true
  def eat_ghost?(_power_pellet_active, _touching_ghost), do: false

  def score?(true, _touching_dot), do: true
  def score?(_touching_power_pellet, true), do: true
  def score?(_touching_power_pellet, _touching_dot), do: false

  def lose?(false, true), do: true
  def lose?(_power_pellet_active, _touching_ghost), do: false

  def win?(true, power_pellet_active, touching_ghost),
    do: not lose?(power_pellet_active, touching_ghost)

  def win?(_has_eaten_all_dots, _power_pellet_active, _touching_ghost), do: false
end
