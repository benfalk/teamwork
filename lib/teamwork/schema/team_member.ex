defmodule Teamwork.Schema.TeamMember do
  use Teamwork.Schema
  # alias __MODULE__, as: TeamMember
  alias Teamwork.Schema.{User, Team}

  @role_values [
    :admin,
    :moderator,
    :user
  ]

  @primary_key false
  schema "team_members" do
    field(:role, Ecto.Enum, values: @role_values)
    belongs_to(:user, User, primary_key: true)
    belongs_to(:team, Team, primary_key: true)
    timestamps()
  end
end
