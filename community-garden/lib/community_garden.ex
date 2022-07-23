# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ [])

  def start(opts) do
    Agent.start(fn -> {opts, 0} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {regisration, _} -> regisration end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(
      pid,
      fn {plots, next_id} ->
        plot = %Plot{plot_id: next_id + 1, registered_to: register_to}
        {plot, {[plot | plots], next_id + 1}}
      end
    )
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {plots, next_id} ->
      {Enum.filter(plots, &(&1 == plot_id)), next_id}
    end)
  end

  def get_registration(pid, plot_id) do
    list_registrations(pid)
    |> Enum.find({:not_found, "plot is unregistered"}, &(Map.get(&1, :plot_id) == plot_id))
  end
end
