defmodule TeamworkWeb.PageLive do
  use TeamworkWeb, :live_view
  require Logger
  alias Teamwork.Schema.Team
  alias Teamwork.TeamAdministration

  @impl true
  def mount(_params, session, socket) do
    user = session["current_user"]

    {:ok,
     assign(socket,
       teams: Teamwork.Account.fetch_teams(user),
       new_team: Team.new(),
       current_user: user
     )}
  end

  @impl true
  def handle_event("create_team", %{"team" => params}, socket) do
    updated_socket =
      socket.assigns.current_user
      |> TeamAdministration.create_team(params)
      |> case do
        {:ok, %{team: team}} ->
          assign(socket, teams: [team | socket.assigns.teams])
      end

    {:noreply, updated_socket}
  end
end
