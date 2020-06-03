defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earh_period_inseconds 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    planet_periods_to_earh = %{
      neptune: 164.79132,
      uranus: 84.016846,
      saturn: 29.447498,
      jupiter: 11.862615,
      mars: 1.8808158,
      venus: 0.61519726,
      mercury: 0.2408467,
      earth: 1
    }

    seconds / (@earh_period_inseconds * planet_periods_to_earh[planet])
  end
end
