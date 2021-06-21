defmodule Teamwork.Schema.User do
  use Teamwork.Schema
  alias __MODULE__, as: User
  alias Teamwork.Schema.TeamMember

  schema "users" do
    field(:email, :string)
    field(:avatar, :string)
    has_many(:team_members, TeamMember)
    has_many(:teams, through: [:team_members, :team])
    timestamps()
  end

  def new(params \\ %{}), do: changeset(%User{}, params)

  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :avatar])
    |> validate_required([:email, :avatar])
    |> unique_constraint(:email, name: :index_accounts_lowercase_email)
  end
end
