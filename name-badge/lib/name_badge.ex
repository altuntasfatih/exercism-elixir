defmodule NameBadge do

  def print(id, name, department) do
    id = if id, do: "[#{id}] - ", else: ""
    department = if department, do: "#{String.upcase(department)}", else: "OWNER"

    id <> "#{name} - " <> department
  end
end
