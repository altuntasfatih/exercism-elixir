defmodule Tournament do
  defstruct mp: 0, w: 0, d: 0, l: 0, p: 0
  @format "| MP |  W |  D |  L |  P"
  @team_name "Team                           "

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.filter(fn item -> item != "" end)
    |> Enum.reduce(%{}, fn item, acc ->
      reduce(acc, String.split(item, ";"))
    end)
    |> Map.to_list()
    |> Enum.sort(fn {name_1, t1}, {name_2, t2} -> compare?(name_1, t1, name_2, t2) end)
    |> print_tally()
  end

  def reduce(acc, [teamA, teamB, result]) do
    with tA <- Map.get(acc, teamA, %Tournament{}),
         tB <- Map.get(acc, teamB, %Tournament{}) do
      [tA, tB] =
        case result do
          "win" -> [tA |> win, tB |> loss]
          "loss" -> [tA |> loss, tB |> win]
          "draw" -> [tA |> draw, tB |> draw]
          _ -> [nil, nil]
        end

      update_map(acc, teamA, tA)
      |> update_map(teamB, tB)
    end
  end

  def reduce(acc, _), do: acc

  def update_map(acc, _, nil), do: acc
  def update_map(acc, key, new), do: Map.put(acc, key, new)

  def print_tally(result) do
    result
    |> Enum.reduce(
      @team_name <> @format,
      fn {name, t}, acc ->
        acc <> "\n" <> get_name(name) <> "|  #{t.mp} |  #{t.w} |  #{t.d} |  #{t.l} |  #{t.p}"
      end
    )
  end

  defp get_name(name) do
    name <> String.duplicate(" ", String.length(@team_name) - String.length(name))
  end

  defp compare?(name_1, %Tournament{p: p1}, name_2, %Tournament{p: p1}), do: name_1 < name_2
  defp compare?(_, %Tournament{p: p1}, _, %Tournament{p: p2}), do: p1 > p2

  def win(team) do
    %{team | w: team.w + 1, p: team.p + 3, mp: team.mp + 1}
  end

  def loss(team) do
    %{team | l: team.l + 1, mp: team.mp + 1}
  end

  def draw(team) do
    %{team | d: team.d + 1, p: team.p + 1, mp: team.mp + 1}
  end
end
