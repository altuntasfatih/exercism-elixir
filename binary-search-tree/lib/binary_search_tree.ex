defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  def insert(nil, data) do
    %{data: data, left: nil, right: nil}
  end

  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    if data <= tree.data do
      %{tree | left: insert(tree.left, data)}
    else
      %{tree | right: insert(tree.right, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  def in_order(nil, acc) do
    acc
  end

  def in_order(tree, acc) do
    acc = in_order(tree.left, acc)
    acc = [tree.data | acc]
    in_order(tree.right, acc)
  end

  def in_order(tree) do
    in_order(tree, [])
    |> Enum.reverse()
  end
end
