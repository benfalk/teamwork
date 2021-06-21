defmodule Teamwork.Schema.Team do
  use Teamwork.Schema
  alias __MODULE__, as: Team
  alias Teamwork.Schema.TeamMember

  schema "teams" do
    field(:name, :string)
    has_many(:team_members, TeamMember)
    has_many(:team_users, through: [:team_members, :user])
    timestamps()
  end

  def new(params \\ %{}), do: changeset(%Team{}, params)

  def changeset(%Team{} = team, params \\ %{}) do
    team
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
