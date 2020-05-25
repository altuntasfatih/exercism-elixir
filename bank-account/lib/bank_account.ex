defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """

  @impl true
  def init(_) do
    :ets.new(__MODULE__, [:named_table,:set, :public])
    {:ok, nil}
  end

  @impl true
  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end

  @impl true
  def handle_cast({:update, amount}, balance) do
    {:noreply, balance + amount}
  end

  @impl true
  def terminate(:normal, _) do
  end

  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(BankAccount, 0)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    proxy(account, fn -> GenServer.stop(account) end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    proxy(account, fn -> GenServer.call(account, :balance) end)
  end

  defp proxy(pid, f) do
    if Process.alive?(pid) do
      f.()
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    proxy(account, fn -> GenServer.cast(account, {:update, amount}) end)
  end
end
