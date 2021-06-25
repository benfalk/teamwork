defmodule Teamwork.Account do
  use Teamwork.Context
  require Logger
  alias Teamwork.Schema.{Team, TeamMember, User}

  def find_or_create_from_auth(%{strategy: Ueberauth.Strategy.Google} = auth) do
    find_or_create(%{
      email: auth.info.email,
      avatar: auth.info.image
    })
  end

  def find_or_create_from_auth(auth) do
    Logger.error("Unsupported Auth: #{inspect(auth)}")

    {:error, "auth not supported"}
  end

  def fetch_teams(%User{id: id}) do
    from(
      team in Team,
      join: member in TeamMember,
      on: member.user_id == ^id and member.team_id == team.id,
      select: %{team: team, role: member.role}
    )
    |> Repo.all()
  end

  def fetch_teams(nil), do: []

  # Private Functions

  defp find_or_create(%{email: email} = params) do
    case find_by_email(email) do
      nil ->
        params
        |> User.new()
        |> Repo.insert()

      %User{} = user ->
        user
        |> User.changeset(params)
        |> Repo.update()
    end
  end

  defp find_by_email(email) do
    from(
      u in User,
      where: fragment("lower(?)", u.email) == fragment("lower(?)", ^email)
    )
    |> Repo.one()
  end
end
