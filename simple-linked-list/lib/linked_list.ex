defmodule LinkedList do
  @opaque t :: tuple()

  @empty_list {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {nil, nil}
    # Your implementation here...
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({nil, nil}, count), do: count
  def length({_, tail}, count), do: length(tail, count + 1)

  def length(list) do
    length(list, 0)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, nil}), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  def peek({nil, nil}) do
    @empty_list
  end

  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({head, _}) do
    {:ok, head}
  end

  @doc """
  Get tail of a LinkedList
  """

  def tail({nil, nil}) do
    @empty_list
  end

  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({_, tail}) do
    {:ok, tail}
  end

  @doc """
  Remove the head from a LinkedList
  """
  def pop({nil, nil}) do
    @empty_list
  end

  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({head, t}) do
    {:ok, head, t}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """

  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(new(), &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    to_list(list, [])
    |> Enum.reverse()
  end

  def to_list({nil, nil}, acc) do
    acc
  end

  def to_list({head, tail}, acc) do
    to_list(tail, [head | acc])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_list()
    |> Enum.reverse()
    |> from_list()
  end
end
