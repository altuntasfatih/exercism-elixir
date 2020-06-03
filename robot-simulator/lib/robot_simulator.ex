defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  @directions [:north, :east, :south, :west]
  @direction_to_movement %{north: {0, 1}, east: {1, 0}, south: {0, -1}, west: {-1, 0}}
  defguard is_direction(term) when term in @directions

  defguard is_position(term)
           when is_tuple(term) and tuple_size(term) == 2 and is_integer(elem(term, 0)) and
                  is_integer(elem(term, 1))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  def create() do
    %RobotSimulator{}
  end

  def create(d, p) when is_direction(d) and is_position(p),
    do: %RobotSimulator{position: p, direction: d}

  def create(d, _) when not is_direction(d), do: {:error, "invalid direction"}

  def create(_, p) when not is_position(p),
    do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.codepoints(instructions)
    |> Enum.reduce(robot, fn i, r -> move(i, r) end)
  end

  defp move("R", %RobotSimulator{} = r) do
    Enum.find_index(@directions, fn x -> x == r.direction end) + 1
    |> move(r)
  end

  defp move("L", %RobotSimulator{} = r) do
    Enum.find_index(@directions, fn x -> x == r.direction end) - 1
    |> move(r)
  end

  defp move(index, %RobotSimulator{} = r) when is_integer(index) do
    %RobotSimulator{r | direction: Enum.at(@directions, rem(index, 4))}
  end

  defp move("A", %RobotSimulator{} = r) do
    {x, y} = Map.get(@direction_to_movement, r.direction)
    {x, y} = {elem(r.position, 0) + x, elem(r.position, 1) + y}
    %RobotSimulator{r | position: {x, y}}
  end

  defp move(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
