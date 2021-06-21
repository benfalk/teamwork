defmodule Teamwork.TeamAdministration do
  use Teamwork.Context
  alias Ecto.Multi
  alias Teamwork.Schema.{Team, User}
  alias Teamwork.Schema.TeamMember, as: Membership

  def create_team(%User{id: user_id}, team_params) do
    Multi.new()
    |> Multi.insert(:team, Team.new(team_params))
    |> Multi.insert(:membership, fn %{team: team} ->
      %Membership{
        user_id: user_id,
        team_id: team.id,
        role: :admin
      }
    end)
    |> Repo.transaction()
  end
end
