defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @class [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  def info(info_string, student_names) do
    String.split(info_string, "\n")
    |> Enum.map(fn x -> String.codepoints(x) end)
    |> Enum.map(fn x -> Enum.chunk_every(x, 2) end)
    |> Enum.reduce(%{}, fn x, acc ->
      fill_map(x, acc)
    end)
    |> assign_students(student_names)
  end

  def info(info_string) do
    info(info_string, @class)
  end

  defp fill_map(window, acc) do
    Enum.with_index(window)
    |> Enum.reduce(acc, fn {plants, index}, acc ->
      Map.update(acc, index, Enum.join(plants), fn old ->
        old <> Enum.join(plants)
      end)
    end)
  end

  defp assign_students(map, students) do
    Enum.sort(students)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {student, index}, acc ->
      Map.put(acc, student, convert_plant_name(Map.get(map, index)))
    end)
  end

  defp convert_plant_name(nil), do: {}

  defp convert_plant_name(plants) do
    String.codepoints(plants)
    |> Enum.reduce({}, fn plant, acc ->
      Tuple.append(acc, plant_name(plant))
    end)
  end

  defp plant_name("V"), do: :violets
  defp plant_name("C"), do: :clover
  defp plant_name("R"), do: :radishes
  defp plant_name("G"), do: :grass
end
