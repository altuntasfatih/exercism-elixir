defmodule Bowling do
  defguard spare?(x, y) when x + y == 10
  defguard valid?(x, y) when x + y <= 10

  defstruct current: {1, nil, nil}, history: %{}
  @tenth_frame 10
  @strike 10

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %Bowling{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  def roll(%Bowling{current: nil}, _), do: {:error, "Cannot roll after game is over"}
  def roll(_, pin_count) when pin_count < 0, do: {:error, "Negative roll is invalid"}
  def roll(_, pin_count) when pin_count > 10, do: {:error, "Pin count exceeds pins on the lane"}

  @spec roll(any, integer) :: any | String.t()
  def roll(game = %Bowling{current: {@tenth_frame, nil, nil}}, @strike) do
    %Bowling{game | current: {@tenth_frame, @strike, nil, nil}}
  end

  def roll(game = %Bowling{current: {@tenth_frame, @strike, nil, nil}}, knocked_pins) do
    %Bowling{game | current: {@tenth_frame, @strike, knocked_pins, nil}}
  end

  def roll(game = %Bowling{current: {@tenth_frame, @strike, @strike, nil}}, knocked_pins) do
    record_history(game, @tenth_frame, {@strike, @strike, knocked_pins})
    |> next_frame()
  end

  def roll(%Bowling{current: {@tenth_frame, @strike, b2, nil}}, knocked_pins)
      when not valid?(b2, knocked_pins) do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(game = %Bowling{current: {@tenth_frame, @strike, b2, nil}}, knocked_pins) do
    record_history(game, @tenth_frame, {@strike, b2, knocked_pins})
    |> next_frame()
  end

  def roll(game = %Bowling{current: {@tenth_frame, nil, nil}}, knocked_pins) do
    %Bowling{game | current: {@tenth_frame, knocked_pins, nil}}
  end

  def roll(game = %Bowling{current: {@tenth_frame, b1, nil}}, knocked_pins)
      when spare?(b1, knocked_pins) do
    %Bowling{game | current: {@tenth_frame, b1, knocked_pins, nil}}
  end

  def roll(game = %Bowling{current: {@tenth_frame, b1, b2, nil}}, knocked_pins) do
    record_history(game, @tenth_frame, {b1, b2, knocked_pins})
    |> next_frame()
  end

  def roll(game = %Bowling{current: {index, nil, nil}}, @strike) do
    record_history(game, index, {"X"})
    |> next_frame()
  end

  def roll(game = %Bowling{current: {index, nil, nil}}, knocked_pins) do
    %Bowling{game | current: {index, knocked_pins, nil}}
  end

  def roll(game = %Bowling{current: {index, b1, nil}}, knocked_pins)
      when spare?(b1, knocked_pins) do
    record_history(game, index, {b1, "/"})
    |> next_frame()
  end

  def roll(%Bowling{current: {_, b1, nil}}, knocked_pins) when not valid?(b1, knocked_pins) do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(game = %Bowling{current: {index, b1, nil}}, knocked_pins) do
    record_history(game, index, {b1, knocked_pins})
    |> next_frame()
  end

  defp next_frame(game = %Bowling{current: {frame, _, _}}) when frame < 10 do
    %Bowling{game | current: {frame + 1, nil, nil}}
  end

  defp next_frame(game) do
    finish_game(game)
  end

  defp record_history(game, index, result) do
    Map.update(game, :history, %{index => result}, fn old ->
      Map.put(old, index, result)
    end)
  end

  defp finish_game(game) do
    Map.put(game, :current, nil)
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(game = %Bowling{current: nil}) do
    Enum.to_list(10..1)
    |> Enum.reduce(
      0,
      fn frame, acc ->
        calculate(game.history, frame, game.history[frame], acc)
      end
    )
  end

  def score(_), do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate(history, frame, {"X"}, acc), do: acc + 10 + strike_score(history, frame)
  defp calculate(history, frame, {_, "/"}, acc), do: acc + 10 + spare_score(history, frame)
  defp calculate(_, _, {x, y}, acc), do: acc + x + y
  defp calculate(_, _, {x, y, z}, acc), do: acc + x + y + z

  defp spare_score(history, frame) do
    case Map.get(history, frame + 1) do
      {"X"} -> 10
      x -> elem(x, 0)
    end
  end

  defp strike_score(history, frame) do
    case Map.get(history, frame + 1) do
      {"X"} -> 10 + spare_score(history, frame + 1)
      {_, "/"} -> 10
      x -> elem(x, 0) + elem(x, 1)
    end
  end
end
