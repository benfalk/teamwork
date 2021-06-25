defmodule TeamworkWeb.PageLive do
  use TeamworkWeb, :live_view
  require Logger

  @impl true
  def mount(_params, session, socket) do
    user = session["current_user"]

    {:ok,
     assign(socket,
       teams: Teamwork.Account.fetch_teams(user),
       current_user: user
     )}
  end

  @impl true
  def handle_info({:team_added, team}, socket) do
    team_data = %{team: team, role: :admin}
    {:noreply, assign(socket, teams: [team_data | socket.assigns.teams])}
  end
end
