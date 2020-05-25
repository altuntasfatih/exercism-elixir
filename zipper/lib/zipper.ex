defmodule Zipper do

  defstruct [:tree, :directions]
  @type t :: %Zipper{tree: BinTree.t(), directions: [] | nil}

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{tree: bin_tree, directions: []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(zipper) do
    Enum.reduce(zipper.directions,zipper.tree, fn head,acc ->
      case head do
        [:L,v,r] -> %BinTree{value: v, left: acc, right: r}
        [:R,v,l] ->  %BinTree{value: v, left: l, right: acc}
      end
    end)
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.tree.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{tree: %{left: nil}}), do: nil
  def left(zipper) do
    value=zipper.tree.value
    left=zipper.tree.left
    right=zipper.tree.right

    %Zipper{tree: left, directions: [ [:L,value,right] | zipper.directions]}
  end


  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{tree: %{right: nil}}), do: nil
  def right(zipper) do
    value=zipper.tree.value
    left=zipper.tree.left
    right=zipper.tree.right

    %Zipper{tree: right, directions: [ [:R,value,left] | zipper.directions]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{directions: []}), do: nil
  def up(zipper= %Zipper{directions: [head | tail ]}) do
    case head do
      [:L,v,r] -> %Zipper{tree: %BinTree{value: v, left: zipper.tree, right: r}, directions: tail}
      [:R,v,l] ->  %Zipper{tree: %BinTree{value: v, left: l, right: zipper.tree},directions: tail}
    end
  end


  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    %{zipper | tree: Map.put(zipper.tree, :value, value)}
  end


  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    %{zipper | tree: Map.put(zipper.tree, :left, left)}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    %{zipper | tree: Map.put(zipper.tree, :right, right)}
  end


end
