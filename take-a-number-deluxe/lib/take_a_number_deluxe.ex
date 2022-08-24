defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(args) do
    GenServer.start_link(TakeANumberDeluxe, args)
  end

  @impl GenServer
  def init(args) do
    case State.new(
           Keyword.get(args, :min_number),
           Keyword.get(args, :max_number),
           Keyword.get(args, :auto_shutdown_timeout, :infinity)
         ) do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      {:error, err} -> {:stop, err}
    end
  end

  @impl GenServer
  def handle_call(:report, _from, %State{auto_shutdown_timeout: timeout} = s) do
    {:reply, s, s, timeout}
  end

  @impl GenServer
  def handle_call(:queue, _from, %State{auto_shutdown_timeout: timeout} = s) do
    case State.queue_new_number(s) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, timeout}

      err ->
        {:reply, err, s, timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve, priority_number}, _from, %State{auto_shutdown_timeout: timeout} = s) do
    case State.serve_next_queued_number(s, priority_number) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, timeout}

      err ->
        {:reply, err, s, timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, s) do
    {:ok, s} = State.new(s.min_number, s.max_number, s.auto_shutdown_timeout)
    {:noreply, s, s.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, s), do: {:stop, :normal, s}

  @impl GenServer
  def handle_info(_, %State{auto_shutdown_timeout: timeout} = s), do: {:noreply, s, timeout}

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :report)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset)
end
