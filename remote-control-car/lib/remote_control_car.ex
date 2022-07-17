defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct battery_percentage: 100,
            distance_driven_in_meters: 0,
            nickname: nil

  def new(nickname \\ "none")
  def new(nickname), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}),
    do: "#{distance} meters"

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%RemoteControlCar{battery_percentage: battery}),
    do: "Battery at #{battery}%"

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car

  def drive(
        %RemoteControlCar{battery_percentage: battery, distance_driven_in_meters: distance} = car
      ) do
    %{car | battery_percentage: battery - 1, distance_driven_in_meters: distance + 20}
  end
end
